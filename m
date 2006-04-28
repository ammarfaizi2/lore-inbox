Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWD1QqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWD1QqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWD1QqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:46:08 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49407 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030449AbWD1QqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:46:05 -0400
Date: Fri, 28 Apr 2006 18:46:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
Message-ID: <20060428164601.GA10420@osiris.ibm.com>
References: <20060424150544.GL15613@skybase> <20060428073358.GA15166@filer.fsl.cs.sunysb.edu> <20060428083903.GA11819@osiris.boeblingen.de.ibm.com> <1146216285.5138.1.camel@localhost> <44521BE6.8040500@grupopie.com> <1146236009.26676.18.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146236009.26676.18.camel@localhost>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >>>>+#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */
> >                                  ^^^^^^^^^^^^^^^^^^^^
> > 				Expression A
> > >>(5 * 60 * USEC_PER_SEC) would probably look better...
> >    ^^^^^^^^^^^^^^^^^^^^^^^
> >    Expression B
> > 
> > I'm no s390 expert either, but just wanted to point out that expression 
> > B is 10 times larger than expression A, so something's fishy here.
> 
> Indeed, 5*60*100*1000 is wrong. That should be 5*60*1000*1000. This must
> have been the week of stupid bugs.. thanks for spotting this.

*sigh*... stupid me. At least this doesn't break anything and with this
patch it's still better than before.
