Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935373AbWKZMk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935373AbWKZMk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 07:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935374AbWKZMk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 07:40:26 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:527 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S935373AbWKZMk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 07:40:26 -0500
Message-ID: <45698B38.7040507@superbug.co.uk>
Date: Sun, 26 Nov 2006 12:40:24 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Casey Dahlin <cjdahlin@ncsu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Overriding X on panic
References: <1164434093.10503.2.camel@localhost.localdomain> <20061125160954.239e0d7e@localhost.localdomain>
In-Reply-To: <20061125160954.239e0d7e@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Sat, 25 Nov 2006 00:54:53 -0500
> Casey Dahlin <cjdahlin@ncsu.edu> wrote:
> 
>> Linus did say that he would do anything within reason to help desktop
>> linux forward, and frankly a big step forward would be to get error
>> messages to the user. What might be some safe options for overriding,
>> switching away from, killing, or otherwise disposing of the X server
>> when an unrecoverable Oops is about to occur on the TTY?
> 
> Assuming frame buffer support is present in the kernel you need an ioctl
> that specifies the frame buffer depth/layout so the kernel can print
> correctly on it. At that point most of the time you'll get the report out
> - more than trying to mode switch probably.
> 
> Send patches
> 
> Alan

I agree. Getting the kernel to write out to the current display mode, 
instead of having to change display mode would be less risky.
It does not have to be fast, and would only need a very simple font, 
enough to display an oops.

Other options are enabling some sort of oops writing to some PCI cards.
E.g. Some Creative sound cards remember some settings over a warm boot, 
so one could write out the oops there, and have code to auto detect it 
when the system is rebooted. I only noticed this when reverse 
engineering some creative sound cards, and rebooting from windows to 
linux made my test linux driver make sound, but would only work if one 
booted into windows first, then warm boot to linux. How many bytes are 
needed for an oops?

James



