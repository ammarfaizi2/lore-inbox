Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWIJJdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWIJJdU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 05:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWIJJdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 05:33:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:43185 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750791AbWIJJdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 05:33:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: curious <curious@zjeby.dyndns.org>
Subject: Re: swsusp problem
Date: Sun, 10 Sep 2006 11:33:32 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
In-Reply-To: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101133.32931.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 10 September 2006 02:13, curious wrote:
> hello.
> i write because swsuspend don't work for me.
> i try to echo disk > /sys/power/state
> and just nothing happens, i have blinking cursor and machine freezes.
> 
> when i enabled debug i got :
> stopping tasks: ========|
> Shrinking memory... done (2684 pages freed)
> swsusp: Need to copy 1454 pages
> swsusp: critical section/: done (1454 pages copied)
> 
> .... and machine just sits there , doing nothing.
> after reboot it boots like usual.
> 
> machine is Ts30M Viglen Dossier 486 SM
> kernel is 2.6.18-rc5
> here is config : http://zjeby.dyndns.org:8242/viglen.config

Could you boot the kernel with the init=/bin/bash command line argument
and do the following:

# mount /proc
# mount /sys
# echo 8 > /proc/sys/kernel/printk
# swapon -a
# echo disk > /sys/power/state

and see what happens?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
