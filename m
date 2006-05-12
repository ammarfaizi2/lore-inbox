Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWELIFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWELIFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWELIFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:05:32 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:22743 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751069AbWELIFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:05:30 -0400
Subject: Re: [RFC][PATCH RT 1/2] futex_requeue-optimize
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
In-Reply-To: <20060511091541.05160b2c.akpm@osdl.org>
References: <20060510112701.7ea3a749@frecb000686>
	 <20060511091541.05160b2c.akpm@osdl.org>
Date: Fri, 12 May 2006 10:09:49 +0200
Message-Id: <1147421390.3969.58.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 10:08:30,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 10:08:32,
	Serialize complete at 12/05/2006 10:08:32
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 09:15 -0700, Andrew Morton wrote:
> Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> >
> > 
> > 
> >   In futex_requeue(), when the 2 futexes keys hash to the same bucket, there
> > is no need to move the futex_q to the end of the bucket list.
> > 
> > ...
> > 
> For some reason I get a reject when applying this.  Which is odd, because I
> see no differences in there.  Oh well - please try to work out what went
> wrong and double-check that the patch which I applied still makes sense.

  Yep, it's due to the futex_hash_bucket renaming from ->bh to ->hb that
went into pi-futex-futex-code-cleanups.patch from the PI-futex
patchset - no harm.

  Sébastien.

