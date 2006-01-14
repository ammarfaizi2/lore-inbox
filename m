Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWANSpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWANSpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWANSpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:45:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:17342 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750756AbWANSpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:45:16 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.15-git breaks Xorg on em64t
Date: Sat, 14 Jan 2006 19:43:27 +0100
User-Agent: KMail/1.8
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060114065235.GA4539@redhat.com>
In-Reply-To: <20060114065235.GA4539@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141943.28027.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 07:52, Dave Jones wrote:
> Andi,
>  Sometime in the last week something was introduced to Linus'
> tree which makes my dual EM64T go nuts when X tries to start.
> By "go nuts", I mean it does various random things, seen so
> far..
> - Machine check. (I'm convinced this isn't a hardware problem
>   despite the new addition telling me otherwise :)

Normally it should be impossible to cause machine checks from software
on Intel systems.

> - Reboot
> - Total lockup
> - NMI watchdog firing, and then lockup
>
> I've tried backing out a handful of the x86-64 patches, and
> didn't get too far, as some of them are dependant on others,
> it quickly became a real mess to try to bisect where exactly it broke.\

Shouldn't be too bad - i did a binary search for something else and it worked 
pretty well.
>
> Any ideas for potential candidates to try & back out ?

Does it work when you revert all x86-64 changes?

-Andi
