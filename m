Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263924AbSITXHp>; Fri, 20 Sep 2002 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263925AbSITXHo>; Fri, 20 Sep 2002 19:07:44 -0400
Received: from ns.suse.de ([213.95.15.193]:4102 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263924AbSITXHh>;
	Fri, 20 Sep 2002 19:07:37 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, msinz@wgate.com
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
References: <3D8B87C7.7040106@wgate.com.suse.lists.linux.kernel> <3D8B8CAB.103C6CB8@digeo.com.suse.lists.linux.kernel> <3D8B934A.1060900@wgate.com.suse.lists.linux.kernel> <3D8B982A.2ABAA64C@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Sep 2002 01:12:43 +0200
In-Reply-To: Andrew Morton's message of "20 Sep 2002 23:54:34 +0200"
Message-ID: <p73bs6stfv8.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> True, but it's all more code and I don't believe that it adds
> much value.  It means that people need to run off and find

One useful feature of it would be that you can get core dumps for 
each thread by including the pid (or tid later with newer threading libraries)
Currently threads when core dumping overwrite each others cores so you lose
the registers of all but one.

Doing multithreaded coredump correctly is a lot more code than this.

Another useful application of an arbitary path name would be dumping to a 
named pipe and having a dr.watson that logs the backtrace to the system log
(of course this has interesting deadlock possibilities when you're not
careful...) 

I would find the feature useful.

-Andi

