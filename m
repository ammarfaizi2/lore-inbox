Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRLTGio>; Thu, 20 Dec 2001 01:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282805AbRLTGie>; Thu, 20 Dec 2001 01:38:34 -0500
Received: from svr3.applink.net ([206.50.88.3]:269 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S280190AbRLTGiO>;
	Thu, 20 Dec 2001 01:38:14 -0500
Message-Id: <200112200637.fBK6b2Sr014173@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Scheduler, Can we save some juice ...
Date: Thu, 20 Dec 2001 00:33:23 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 21:50, Rik van Riel wrote:
> On Tue, 18 Dec 2001, Linus Torvalds wrote:
> > The thing is, I'm personally very suspicious of the "features for that
> > exclusive 0.1%" mentality.
>
> Then why do we have sendfile(), or that idiotic sys_readahead() ?
>
> (is there _any_ use for sys_readahead() ?  at all ?)
>
> cheers,
>
> Rik


OK, here's another 0.1% for you.  Considering how Linux SMP
doesn't have high CPU affinity, would it be possible to make a
patch such that the additional CPUs remain in deep sleep/HALT
mode until the first CPU hits a high-water mark of say 90% 
utilization?  I've started doing this by hand with the (x)pulse
application.   My goal is to save electricity and cut down on 
excess heat when I'm just browsing the web and not compiling
or seti@home'ing.


-- 
timothy.covell@ashavan.org.
