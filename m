Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbVIPN4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbVIPN4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 09:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVIPN4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 09:56:35 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:37160 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161096AbVIPN4e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 09:56:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oz0zW0SPzWFel2gPk+C34qfAYEw+ReZpQ3TOS2ykZY6jJX5q7Q75TQosTdAHT7CwG81MdZi9BiPfIo3gSIsEAh2nMpF0/VD2xBIye43XsFigmifY4fJo/fvIcKZACElFpADfWlyM4L4J00Tf6DdLt1Qpn23ks0oBAUQ1DfSYSVE=
Message-ID: <9a87484905091606564559fadd@mail.gmail.com>
Date: Fri, 16 Sep 2005 15:56:33 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: early printk timings way off
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0509161226440.19898@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509152342.24922.jesper.juhl@gmail.com>
	 <Pine.LNX.4.58.0509151458330.1800@shark.he.net>
	 <9a87484905091515072c7dd4a8@mail.gmail.com>
	 <Pine.LNX.4.53.0509161202450.19735@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.53.0509161226440.19898@gockel.physik3.uni-rostock.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> On Fri, 16 Sep 2005, Tim Schmielau wrote:
> 
> > On Fri, 16 Sep 2005, Jesper Juhl wrote:
> > > It also doesn't
> > > explain why two lines, the first with timing value 0.000, and the next
> > > with 27.121 don't seem to match reality - the *actual* delta between
> > > printing those two lines is far lower than 27 seconds.
> >
> > Yes, this seems to be different, possibly unrelated problem.
> > It's interesting that the value jumps _exactly_to_zero_, though.
> > Will need to dig into the code...
> 
> Did that.
> The problem is that printk uses sched_clock() to determine the time, which
> just isn't supposed to be a reliable long-time clock. We need to base the
> output on a different clock.
> 
> Btw, the rate-limiting logic in printk.c looks 'interesting'. Will look
> into that, too.
> 

Thanks Tim, much appreciated.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
