Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbTGJJJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbTGJJJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:09:13 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:19162 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S265795AbTGJJJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:09:11 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
Date: Thu, 10 Jul 2003 11:22:56 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <20030709021849.31eb3aec.akpm@osdl.org> <1057815890.22772.19.camel@www.piet.net>
In-Reply-To: <1057815890.22772.19.camel@www.piet.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200307101122.59138.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 07:44, Piet Delaney wrote:
> On Wed, 2003-07-09 at 02:18, Andrew Morton wrote:
> > Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> .
> .
> .
>
> > Seems complex.  I just have this:

~~snip~~

> I'll settle for Matt Mackall <mpm@selenic.com> fix for now:
>
>     +#define apm_save_cpus()        (current->cpus_allowed)
>
> I wonder why other, like Thomas Schlichter <schlicht@uni-mannheim.de>,
> had no problem with the CPU_MASK_NONE fix.

Well, I didn't try the CPU_MASK_NONE fix. I am using my fix attached to my 
first mail, but Andrew ment it was too complex (your quoting from above). So 
he proposed the simpler fix, wich simply looked good to me...

> I tried adding the #include <linux/cpumask.h> that Marc-Christian
> Petersen <m.c.p@wolk-project.de> sugested but it didn't help. Looks
> like Jan De Luyck <lkml@kcore.org> had a similar result.
>
> -piet

Thomas
