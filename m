Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTJ0ThF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTJ0ThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:37:05 -0500
Received: from yakov.inr.ac.ru ([193.233.7.111]:47511 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S263489AbTJ0ThD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:37:03 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200310271936.WAA07348@yakov.inr.ac.ru>
Subject: Re: Linux 2.6.0-test9
To: torvalds@osdl.org (Linus Torvalds)
Date: Mon, 27 Oct 2003 22:36:21 +0300 (MSK)
Cc: akpm@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org (Kernel Mailing List), netdev@oss.sgi.com,
       davem@redhat.com (David S. Miller), kuznet@ms2.inr.ac.ru
In-Reply-To: <Pine.LNX.4.44.0310261607230.3157-100000@home.osdl.org> from "Linus Torvalds" at Oct 26, 2003 04:21:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> And Alexey apparently tried to do the "FIXME" part, but without thinking 
> about the SIGURG part.

Actually, it was thought a lot for several linux-2.x. :-)


> We _need_ to stop at urgent data and we _should_ return -EINTR, and let
> the SIGURG handler do the URG read. Otherwise we'll lose urgent data (or
> we'll just read it inline without realizing that it was urgent data).

The patch was expected not to break this property. Alas, something
is overlooked yet. I still do not understand what exactly is broken,
I feel I have to find some rlogin to experiment in vivo.

Alexey

