Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbSJ1EZt>; Sun, 27 Oct 2002 23:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbSJ1EZt>; Sun, 27 Oct 2002 23:25:49 -0500
Received: from ns.suse.de ([213.95.15.193]:55816 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262862AbSJ1EZs>;
	Sun, 27 Oct 2002 23:25:48 -0500
Date: Mon, 28 Oct 2002 05:32:08 +0100
From: Andi Kleen <ak@suse.de>
To: Rob Landley <landley@trommello.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021028053208.A5883@wotan.suse.de>
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net> <200210271157.46153.landley@trommello.org> <20021028040637.GN1557@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028040637.GN1557@pimlott.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > C) How would having ALL times rounded to a second be an improvement?
> 
> foo.c and foo.o would both have timestamps of 0.  make considers
> the target foo.o newer in this case, so will not rebuild it.

But other stuff could break because it sees mtime > gettimeofday
(strictly make could trigger a "your clock is warping" warning) 

It's a tradeoff, all has some disadvantages. The simple truncation
wins here because it's the simplest (KISS) 

-Andi
