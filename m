Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUIDKsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUIDKsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269871AbUIDKsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:48:12 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:39368 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S267657AbUIDKsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:48:08 -0400
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
From: Emmanuel Fleury <fleury@cs.aau.dk>
To: umbrella-devel@lists.sourceforge.net
In-Reply-To: <200409032039.i83Kd1ZR028638@turing-police.cc.vt.edu>
References: <41385FA5.806@cs.aau.dk>
	 <1094220870.7975.19.camel@localhost.localdomain> <4138CE6F.10501@cs.aau.dk>
	 <200409032039.i83Kd1ZR028638@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Aalborg University
Message-Id: <1094295006.2463.36.camel@aphrodite.olympus.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 12:50:06 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 22:39, Valdis.Kletnieks@vt.edu wrote:
> 
> All this does is stop fork().  I'm not sure, but most shellcodes I've seen
> don't bother forking, they just execve() a shell....

I think you totally misunderstood the thing...

Umbrella is a scheme that allow the user to restrict the capabilities of
a process within his own processes. Preventing the process to fork is
ONE thing that can be restricted but they might be plenty of others.

The idea is that each process originating from this process will inherit
from this restriction (and possibly have some more) and can NEVER been
granted to restore this capability again.

Now, this has a direct application to restrict the harm that can cause a
buffer-overflow, but nobody said that it would stop them... As Kristian
say all the time: « We can't prevent the rain, but we don't get wet. »

> Remember - just papering over the fact that most shellcodes just execve() a
> shell doesn't fix the fundemental problem, which is that the attacker is able
> to run code of his choosing as root.

Right. 

Wonderful ! You just volunteered to find a simple and yet efficient
solution to this problem ! :)

Regards
-- 
Emmanuel Fleury
 
Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

