Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVEPFgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVEPFgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 01:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVEPFgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 01:36:48 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:5006 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261391AbVEPFgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 01:36:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as /dev/input/mouse0
Date: Mon, 16 May 2005 00:36:30 -0500
User-Agent: KMail/1.8
Cc: Greg Stark <gsstark@mit.edu>
References: <87zmuveoty.fsf@stark.xeocode.com>
In-Reply-To: <87zmuveoty.fsf@stark.xeocode.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505160036.30628.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 00:12, Greg Stark wrote:
> 
> I just updated to 2.6.12-rc4 and now /dev/input/mouse0 seems to be my ps2
> keyboard. My ps2 mouse is now on /dev/input/mouse1.
> 
> 
> Good thing to catch before you release 2.6.12 and get the usual swarm of "my
> mouse stopped working" reports. It seems to be getting to be a pattern:
> upgrade linux kernel -- debug why mouse stopped working.
>

atkbd's scroll support was turned on by default causing mouse moved over a
bit.
 
Please use /dev/input/mice for accessing your mouse. /dev/input/mouseX are
not guaranteed to be stable, if you need stable names you'll have to adjust
your hotplug scripts.
 
-- 
Dmitry
