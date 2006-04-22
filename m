Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWDVTKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWDVTKJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDVTKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:10:08 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12471 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750973AbWDVTKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:10:06 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Al Boldi <a1426z@gawab.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604220708.40018.a1426z@gawab.com>
References: <200604212207.44266.a1426z@gawab.com>
	 <1145657048.21109.583.camel@stark>  <200604220708.40018.a1426z@gawab.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 21 Apr 2006 22:46:40 -0700
Message-Id: <1145684800.21231.30.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 07:08 +0300, Al Boldi wrote:

> i.e: it should be possible to run the RCs w/o CKRM.
> 
> The current design pins the RCs on CKRM, when in fact this is not necessary.  
> One way to decouple them, could be to pin them against pid, thus allowing an 
> RC to leverage the pid hierarchy w/o the need for CKRM.  And only when finer 
> RM control is necessary, should CKRM come into play, by dynamically 
> adjusting the RC to achieve the desired effect.

This model works well in universities, where you associate some resource
when a student logs in, or a virtualised environment (like a UML or
vserver), where you attach resource to the root process.

It doesn't work with web servers, database servers etc.,, where the main
application will be forking tasks for different set of end users. In
that case you have to group tasks that are not related to one another
and attach resources to them.

Having a unified interface gives the system administrator ability to
group the tasks as they see them in real life (a department or important
transactions or just critical apps in a desktop).

It also has the added advantage that the resource controller writer do
not have to spend their time in coming up with an interface for their
controller. On the other hand if they do, the user finally ends up with
multiple interface (/proc, sysfs, configfs, /dev etc.,) to do their
resource management.

> 
> Thanks!
> 
> --
> Al
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


