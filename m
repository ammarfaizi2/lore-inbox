Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266329AbTGEKam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 06:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266332AbTGEKam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 06:30:42 -0400
Received: from [213.39.233.138] ([213.39.233.138]:56970 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266329AbTGEKah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 06:30:37 -0400
Date: Sat, 5 Jul 2003 12:44:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030705104428.GA19311@wohnheim.fh-wedel.de>
References: <20030704201840.GH22152@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0307041725180.1744-100000@home.osdl.org> <20030705073031.GB32363@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030705073031.GB32363@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 July 2003 09:30:31 +0200, Jörn Engel wrote:
> On Fri, 4 July 2003 17:39:01 -0700, Linus Torvalds wrote:
> > 
> > So how about something like the appended? Very simple patch,i and in fact 
> > it's more logical than the old behaviour (the old behaviour punched 
> > through blocked signals, the new ones says "if you block or ignore the 
> > signal we will just kill you through the default action").
> 
> That seems to be the best solution.  Thanks!

Except that the patch didn't match the description.  My test loops
just as happily as before and the conditional part of give_sigsegv is
pointless now.  That might really break some threading stuff.

Anyway, the idea still makes sense, so I will try to come up with a
working patch.

Jörn

-- 
"Translations are and will always be problematic. They inflict violence 
upon two languages." (translation from German)
