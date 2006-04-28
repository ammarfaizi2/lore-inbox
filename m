Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWD1RnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWD1RnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWD1RnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:43:14 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52904 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751481AbWD1RnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:43:13 -0400
Date: Fri, 28 Apr 2006 19:43:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060428174302.GE30532@wohnheim.fh-wedel.de>
References: <20060428025621.2c7577a0.akpm@osdl.org> <OF41D6EA13.CE34B289-ON4225715E.00501AB1-4225715E.0060B9BD@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF41D6EA13.CE34B289-ON4225715E.00501AB1-4225715E.0060B9BD@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 April 2006 19:36:30 +0200, Michael Holzheu wrote:
> Andrew Morton <akpm@osdl.org> wrote on 04/28/2006 11:56:21 AM:
> > Michael Holzheu <holzheu@de.ibm.com> wrote:
> 
> > > +static int diag224_idx2name(int index, char *name)
> > > +{
> > > +   memcpy(name, diag224_cpu_names + ((index + 1) * 16), 16);
> > > +   name[16] = 0;
> >
> > Should this be "15"?   I guess not...
> 
> No bug, our strings here have 16 characters and are not
> 0 terminated.

Hmm.  TMP_SIZE is defined to 64 and used for buffers allocated on the
stack.  It is not too excessive, but in this case 17 would definitely
be enough.  Not sure if it's worth going through.

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
