Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRCQEuy>; Fri, 16 Mar 2001 23:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131547AbRCQEuo>; Fri, 16 Mar 2001 23:50:44 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:44810 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S131402AbRCQEuc>;
	Fri, 16 Mar 2001 23:50:32 -0500
Message-Id: <200103170601.BAA05503@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] big stack variables 
In-Reply-To: Your message of "Fri, 16 Mar 2001 11:58:34 EST."
             <Pine.GSO.4.21.0103161154060.12618-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Mar 2001 01:01:22 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu said:
> ObUML: something fishy happens in UML with multiple exec() in PID 1.
> Try to say "telinit u" (or just boot with init=/bin/sh and say exec /
> sbin/init) and you've got a nice panic()... 

ObFix:  This is fixed in my current CVS.  If you're not so desperate for the 
fix, then it will be in my 2.4.3 release.  Basically, the problem was that it 
assumed that the only exec done by pid 1 was the kernel thread execing init, 
and things got exciting when that turned out not to be true.

				Jeff


