Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267197AbUGMWvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267197AbUGMWvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUGMWuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:50:01 -0400
Received: from quechua.inka.de ([193.197.184.2]:34262 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S267206AbUGMWsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:48:00 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: OT: Java GC (was: Garbage Collection and Swap)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <40F45DEF.8060307@techsource.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BkW44-0008FP-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 14 Jul 2004 00:47:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <40F45DEF.8060307@techsource.com> you wrote:
> I get the impression that the Java VM, for instance, knows what 
> variables are pointers (well, references) and only considers those.  It 
> also knows every object that has even been allocated.  It scans over 
> every pointer it knows about (the "mark" phase), and then it scans over 
> every dynamically allocated memory block (the "sweep" phase) and removes 
> all that have no references.

Well, most VM implementations use an  generative aproach, where fresh
objects are kept in a smaller hot pool and aged out (nursery), expecting
less traversal. It is not enough to keep the marks in a central location
with pointers, since you have actually follow those pointers into the object
and travers the graphs.

http://java.sun.com/products/hotspot/whitepaper.html#5d

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
