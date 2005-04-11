Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVDKQnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVDKQnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVDKQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:40:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63706 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261836AbVDKQhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:37:18 -0400
Date: Mon, 11 Apr 2005 18:36:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: folkert@vanheusden.com,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050411163657.GA23423@elf.ucw.cz>
References: <4259B474.4040407@domdv.de> <20050411102550.GD1353@elf.ucw.cz> <20050411103608.GA5610@vanheusden.com> <20050411110152.GD1373@elf.ucw.cz> <425AA5B7.4000900@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425AA5B7.4000900@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd like to retain ability to read suspend image in any order (so that
> > code can be reused for swap encryption, etc).
> 
> This is not possible with cipher block chaining as used right now. One
> would have to use a non-random iv set needs to set for every page. And
> this leads to exactly the same problem why dm-crypt now offers the
> 'essiv' mode. I don't know if a random access feature is worth this
> effort as sequential disk access (sequential write, sequential read) is
> usally the fastest method anyway.

I thought I'd just reuse your code for automagic swap encryption. Oh
well.


> For regular swap encryption I do hope that the initrd feature of swsup2
> will eventually find its way into the mainline kernel. This way you can
> have an external key for dm-crypt to access the encrypted swap
> partition.

Check -mm kernel, swsusp1 can now do resume from initrd.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
