Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVF0SJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVF0SJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVF0SJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:09:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13990 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261454AbVF0SJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:09:00 -0400
To: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] [patch 25/38] CKRM e18: Add fork rate control to the numtasks controller 
In-reply-to: Your message of Mon, 27 Jun 2005 16:07:50 +0900.
             <42BFA5C6.9040604@jp.fujitsu.com> 
Date: Mon, 27 Jun 2005 11:08:32 -0700
Message-Id: <E1Dmy24-00041J-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Jun 2005 16:07:50 +0900, Naoaki Maeda wrote:
> Gerrit Huizenga wrote:
> 
> > +As with any other resource under the CKRM framework, numtasks also assigns
> > +all the resources to the detault class(/rcfs/taskclass). Since , the number
> > +of tasks in a system is not limited, this resource controller provides a
> > +way to set the total number of tasks available in the system through the config
> > +file. By default this value is 128k(131072). In other words, if not changed,
> > +the total number of tasks allowed in a system is 131072.
> > +
> > +The config variable that affect this is sys_total_tasks.
> 
> Because there are people who do not want to use the numtask controller,
> no limit is a preferable default value for sys_total_tasks.

Hello, Maeda-san, I would be fine with accepting such a patch.  Would
you care to generate a patch and post it?  I will include it in the
next release of CKRM.
 
> > +Usage
> > +-----
> > +
> > +For brevity, unless otherwise specified all the following commands are
> > +executed in the default class (/rcfs/taskclass).
> > +
> > +As explained above the config file shows sys_total_tasks and forkrate
> > +info.
> > +
> > +   # cd /rcfs/taskclass
> > +   # cat config
> > +   res=numtasks,sys_total_tasks=131072,forkrate=1000000,forkrate_interval=3600
> > +
> > +By default, the sys_total_tasks is set to 131072(128k), and forkrate is set
> > +to 1 million and forkrate_interval is set to 3600 seconds. Which means the
> > +total number of tasks in a system is limited to 131072 and the forks are
> > +limited to 1 million per hour.
> 
> From the same point of view, the default value of forkrate should be
> no limit. (In addition, 1 million tasks per hour is not an abnormally
> high rate.)

Again, I agree with this.  A patch for this as well would be welcome.

thanks for your review!

gerrit
