Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWDWUQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWDWUQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 16:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWDWUQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 16:16:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:57288 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751450AbWDWUQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 16:16:57 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Yum Rayan" <yum.rayan@gmail.com>
Subject: Re: [RFC] VBE DDC bios call stalls boot
Date: Sun, 23 Apr 2006 22:14:32 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com>
In-Reply-To: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604232214.32662.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 23. April 2006 21:08, Yum Rayan wrote:
> I don't think boot should stall for any reason. Moreover given that
> user space programs are doing these VBE/DDC calls, I don't see any
> compelling reason why this code need to exist is such early boot
> stage. If it absolutely needs to be called in the kernel, at least if
> invoked sometime later, we could time out this call as a workaround.

Don't configure CONFIG_FB_FIRMWARE_EDID, if it doesn't work
on your hardware. 

Just disable "Enable firmware EDID" in 
"Device Drivers"->"Graphics support"->"Support for frame buffer devices"
of your menuconfig dialog. The help mentions, that this will not always work.

That will make your hardware work flawlessly again.


Regards

Ingo Oeser
