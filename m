Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVF0PCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVF0PCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVF0O6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:58:00 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:36429 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261662AbVF0N1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:27:12 -0400
Date: Mon, 27 Jun 2005 15:27:05 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [ckrm-tech] [patch 25/38] CKRM e18: Add fork rate control to the numtasks controller
Message-ID: <20050627132704.GA3555@bitwizard.nl>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061759.325157000@w-gerrit.beaverton.ibm.com> <42BFA5C6.9040604@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BFA5C6.9040604@jp.fujitsu.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 04:07:50PM +0900, Naoaki Maeda wrote:
> Gerrit Huizenga wrote:>
 > +By default, the sys_total_tasks is set to 131072(128k), and forkrate is set
> > +to 1 million and forkrate_interval is set to 3600 seconds. Which means the
> > +total number of tasks in a system is limited to 131072 and the forks are
> > +limited to 1 million per hour.
> 
> From the same point of view, the default value of forkrate should be
> no limit. (In addition, 1 million tasks per hour is not an abnormally
> high rate.)

It is quite high. however, in some applications I can immagine that a
machine would indeed trigger a very high fork rate.

For example, a machine that runs lots of shell scripts that call each
other, may all of a sudden be forking the required 300/second....

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
