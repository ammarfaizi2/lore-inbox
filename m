Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261977AbSJIRkG>; Wed, 9 Oct 2002 13:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbSJIRkF>; Wed, 9 Oct 2002 13:40:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22802 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261973AbSJIRkA> convert rfc822-to-8bit; Wed, 9 Oct 2002 13:40:00 -0400
Date: Wed, 9 Oct 2002 10:47:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tim Hockin <thockin@hockin.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
In-Reply-To: <200210091738.g99HcBY15929@www.hockin.org>
Message-ID: <Pine.LNX.4.44.0210091046170.7355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g99HjIA27215
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Tim Hockin wrote:
> Linus, This is actually something I sent to Martin (and DaveM).  The __UID16
> crap is because s390x and Sparc64 (and others?) do not want the highuid
> stuff except in very specific places - namely compat code.  Just using
> CONFIG_UID16_SYSCALLS has the same bad side-effect as CONFIG_UID16 - all or
> nothing.  In short, we want to build uid16.o with highuid translations, and
> a few other compat objects, but not everything.  Ugly.

So why don't we just split it up into all the sub-options? So that you 
have a smørgåsbord of real options to select from..

In other words, that __UID16 thing should be a real CONFIG_XXX option.

		Linus


