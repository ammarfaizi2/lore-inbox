Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbSJOPPt>; Tue, 15 Oct 2002 11:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSJOPPt>; Tue, 15 Oct 2002 11:15:49 -0400
Received: from mnh-1-21.mv.com ([207.22.10.53]:47364 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262653AbSJOPPs>;
	Tue, 15 Oct 2002 11:15:48 -0400
Message-Id: <200210151625.LAA02738@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Oleg Drokin <green@namesys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.42-1 
In-Reply-To: Your message of "Tue, 15 Oct 2002 16:00:59 +0400."
             <20021015160059.A6187@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Oct 2002 11:25:30 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

green@namesys.com said:
> Below is quotes from the patch, and at the very end of the message
> there is a my proposed patch to fix all uncovered problems, patch was
> tested as in "compiles and runs ok for me". 

Correct on all counts.  Nice spotting.

> Also there are number "32" is hardcoded into arch/um/kernel/
> trap_user.c in some arrays, taht you probably actually want to make
> dependent on CONFIG_NR_CPUS 

The problem is that trap_user.c is a userspace file and has no access to
config.h.  The hardcoded 32 is nasty and needs fixing, but I haven't decided
how to do that yet.

				Jeff

