Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161319AbWJ3Ruz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbWJ3Ruz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWJ3Ruz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:50:55 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:58803 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1161314AbWJ3Ruy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:50:54 -0500
Message-ID: <45463B7D.8050002@vmware.com>
Date: Mon, 30 Oct 2006 09:50:53 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 is problematic in VMware
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Hello list,
>
>
> I have observed a strange slowdown with the 2.6.18 kernel in VMware. 
> This happened both with the SUSE flavor and with the FC6 installer CD 
> (which I am trying right now). In both cases, the kernel "takes its 
> time" after the following text strings:
>
> * Checking if this processor honours the WP bit even in supervisor mode... Ok.
> * Checking 'hlt' instruction... OK.
>
> What's with that?
>   

Thanks.  It is perhaps the jiffies calibration taking a while because of 
the precise timing loop.  Are you reasonably confident that it is a 
regression in performance over 2.6.17?  The boot sequence is pretty 
complicated, and a lot of it is difficult / slow to virtualize, so it 
could just be alternate timing makes the boot output appear to stall, 
when in fact the raw time is still about the same.  I will run some 
experiments.

Zach
