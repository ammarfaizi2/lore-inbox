Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVF0U7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVF0U7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVF0U7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:59:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55509 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261689AbVF0U44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:56:56 -0400
Date: Mon, 27 Jun 2005 22:56:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>
Subject: Re: [patch 08/38] CKRM e18: Documentation
Message-ID: <20050627205650.GA7278@atrey.karlin.mff.cuni.cz>
References: <20050626212426.GB1315@elf.ucw.cz> <E1Dmybs-0004I0-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dmybs-0004I0-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +CKRM Basics
> > > +-------------
> > 
> > Perhaps you want to explain what "CKRM" means?
>  
> I'll update this to spell out CKRM a bit more.  CKRM stands for
> Class based Kernel Resource Management.  I realize that that is a
> bit wordy but early on the team chose to try to be explicit about what
> was being added.  And, I'm guessing you really don't want to see
> class_base_kernel_resource_management_number_of_tasks as a structure
> name or class_base_kernel_resource_management_register_classification_engine()
> as a function name.  And, while the term class is great for grouping in
> the workload management context, using class_number_of_tasks seems a
> bit presumptious in the kernel naming space.
> 
> I'm inclined to leave the name CKRM as is and improve the documentation
> at this point unless you have a more specific solution which can be
> acceptable to all.

I guess that CKRM was used so much that it is acceptable. But I still
liked beancounter as a better name :-) [it was similar project, IIRC].

> > > Index: linux-2.6.12-ckrm1/Documentation/ckrm/rbce_basics
> > > ===================================================================
> > > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > > +++ linux-2.6.12-ckrm1/Documentation/ckrm/rbce_basics	2005-06-20 13:08:35.000000000 -0700
> > > @@ -0,0 +1,67 @@
> > > +Rule-based Classification Engine (RBCE)
> > > +-------------------------------------------
> > > +
> > > +The ckrm/rbce directory contains the sources for two classification engines
> > > +called rbce and crbce. Both are optional, built as kernel modules and share much
> > > +of their codebase. Only one classification engine (CE) can be loaded at a time
> > > +in CKRM.
> > 
> > TMFLAs! (*)
> > 
> > Your resource managment may be quite nice system, but the naming is
> > definitely very ugly. With your design we would not have open() system
> > call, but ofsoarh() -- open filesystem object and return its
> > handle. Can you come up with some reasonable naming?
> 
> Can you help?  ;)  I'd rather not change CKRM itself at this point - too
> many papers and users and such.   While it is not impossible, I'm not
> sure that it would help.  RCFS seems quite reasonable.  RBCE and CRBCE,
> well, I'm much more likely to get excited about better names here.
> ;)

rcfs would be reasonable; unfortunately we already have those /etc/rc*
directories, and rcfs may confuse people into thinking it does
something with system startup. resourcefs?

RBCE/CRBCE are really bad. SimpleClassifier / CustomClassifier?

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
