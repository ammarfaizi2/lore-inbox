Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVEKVVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVEKVVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVEKVVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:21:30 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:1850 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261268AbVEKVV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:21:28 -0400
Date: Wed, 11 May 2005 23:21:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-kernel@vger.kernel.org,
       kaos@ocs.com.au
Subject: Re: arm: Inconsistent kallsyms data
Message-ID: <20050511212124.GB8127@mars.ravnborg.org>
References: <1115802310.9757.20.camel@mammoth.research.nokia.com> <4281E5AE.4090601@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4281E5AE.4090601@grupopie.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 11:59:58AM +0100, Paulo Marques wrote:
> Imre Deak wrote:
> >Hi,
> >
> >building 2.6.12-rc4 results in "Inconsistent kallsyms data". Setting
> >CONFIG_KALLSYMS_EXTRA_PASS=y doesn't help.
> >
> >I made a diff of .tmp_kallsyms[12].S after converting them to human
> >readable form with kallsyms_uncompress.pl .
> 
> From the diff, I can see the problem is that "__bss_start" changes 
> position with "_edata" from the first to the second pass.
> 
> If your read my post from yesterday "Re: Linux v2.6.12-rc4" (not a very 
> descriptive subject), I explain there why this is a problem.
> 
> Sam, from looking at your patch, it seems that the patch shouldn't 
> affect these particular symbols. Am I correct?
As I read the diff my patch will not solve this problem.
Let's see the output generated with Keith's debug_kallsyms patch if
that will sched some light over it.

	Sam
