Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSGFAhG>; Fri, 5 Jul 2002 20:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSGFAhF>; Fri, 5 Jul 2002 20:37:05 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:7946 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316969AbSGFAhF>; Fri, 5 Jul 2002 20:37:05 -0400
Date: Sat, 6 Jul 2002 02:39:25 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Sandy Harris <pashley@storm.ca>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch,rfc] make depencies on header files explicit
In-Reply-To: <3D253AAE.D73E1E07@storm.ca>
Message-ID: <Pine.LNX.4.33.0207060233520.20192-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Sandy Harris wrote:

> I thought conventional wisdom was that header files should never #include
> other headers, and .c files should explicitly #include all headers they
> need.
> 
> Googling on "nested header" turns up several style guides that agree:
> http://www.cs.mcgill.ca/resourcepages/indian-hill.html
> http://www.doc.ic.ac.uk/lab/secondyear/cstyle/node5.html
> 
> and others that say it is controversial, can be done either way:
> http://www.eskimo.com/~scs/C-faq/q10.7.html
> 
> Am I just off base in relation to kernel coding style? Or would getting
> rid of header file nesting be a useful objective.


Avoiding nested headers certainly results in the smallest set of header 
files actually #included.
However, I think it's just not feasible with the kernel: many files would
start with a list of some hundred includes, and I can't imagine a 
reasonable way to document the dependencies between them.

Tim

