Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSL0PGQ>; Fri, 27 Dec 2002 10:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSL0PGQ>; Fri, 27 Dec 2002 10:06:16 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:53638 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264969AbSL0PFq>; Fri, 27 Dec 2002 10:05:46 -0500
Message-Id: <4.3.2.7.2.20021227161345.00b55180@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 27 Dec 2002 16:14:41 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Linux v2.5.53 pause et al
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > [PATCH] reorder 'rep;nop;' in the spinlock macro
 > According to Intel's recommendation, 'rep;nop; should be called before 
testing
 > if the lock variable was modified (i.e. rep nop;cmp;jcc).
 > The current implementation does it the wrong way around: first test, 
then wait, then branch.
 > I've asked Asit Mallik from Intel, and he recommended to change it.
 > It should be at least consistent: Right now, spinlock uses 'cmp;rep 
nop;jcc',
 > rwlock uses 'rep nop;cmp;jcc'

Hmm. Unless I'm reading it wrong, this doesn't agree with the
example 7-1c on page 7-14 of the P4 Optimization manual,  or ?

This is also interesting  - quote
"The inc and dec instructions should always be avoided. Using add and sub
instructions instead of inc and dec instructions avoid data dependence and
improve performance."


Margit 

