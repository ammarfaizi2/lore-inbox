Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSLHVHx>; Sun, 8 Dec 2002 16:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSLHVHx>; Sun, 8 Dec 2002 16:07:53 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3844 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S261527AbSLHVHw>;
	Sun, 8 Dec 2002 16:07:52 -0500
Date: Sun, 8 Dec 2002 15:06:54 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
cc: rusty@rustcorp.com.au
Subject: Module loading problems in 2.5
Message-ID: <Pine.LNX.4.44.0212081428350.950-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done extensive testing of Rusty's module init tools in the later 2.5 
kernels and I still have problems getting my SMC2632W wireless ethernet 
adapter working in later 2.5 kernels.  However, I'm not sure the problems 
can be associated to the known module loading breakage.

My system is a Presario laptop model 12XL325 with a 650 MHz PIII 
processor.  The OS is RedHat 8.0 with updates.  

Rusty's latest (0.9.1) module init tools work well here with both Linus' 
as well as RedHat-based 2.4 kernels.  In the 2.5 series, module loading 
mostly works through 2.5.41 which breaks the orinoco_cs module.  2.5.42 
through 2.5.45 load and configure eth0 through the SMC card just fine.  
2.5.46 and 2.5.47 load the modules, but oops on shutdown.  2.5.48 and 
following, including 2.5.50-bk, do not autoload modules at all.  I can 
load the required modules by hand, but even that doesn't properly 
configure the eth0 device.

Rusty has been providing various module loading tools for testing, but he 
doesn't believe his changes are responsible for the breakage I'm seeing.  
I have compiled various 2.5.50-bk kernel revisions both with built-in 
drivers as well as modular.  Even building 2.5.50 monolithic doesn't 
result in a functioning eth0 interface.  I've provided Rusty with strace 
output for both successful and unsuccessful module loading situations, but 
he hasn't said anything was remarkable about the data.

I hope some of this will help a developer figure out where the problem 
might lie, or at least give someone a nudge to point me where/what to try 
next.

