Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTHYREs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTHYREs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:04:48 -0400
Received: from havoc.gtf.org ([63.247.75.124]:44746 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262013AbTHYREn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:04:43 -0400
Date: Mon, 25 Aug 2003 13:04:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Dan Aloni <da-x@gmx.net>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825170441.GA7097@gtf.org>
References: <20030825161435.GB8961@callisto.yi.org> <20030825163745.GA17608@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825163745.GA17608@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 06:37:45PM +0200, J?rn Engel wrote:
> On Mon, 25 August 2003 19:14:35 +0300, Dan Aloni wrote:
> > 
> > While working on the fix to network devices names and sysctl,
> > I fought to urge to create yet another strdup() implementation
> > This came up.
> 
> Nice one.
> 
> > +/**
> > + * strdup - Allocate a copy of a string.
> > + * @s: The string to copy. Must not be NULL.
> > + *
> > + * returns the address of the allocation, or NULL on
> > + * error. 
> > + */
> > +char *strdup(const char *s)
> > +{
> > +	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
> > +	if (rv)
> > +		strcpy(rv, s);
> > +	return rv;
> > +}
> 
> My gut feeling is always afraid when something "must not be NULL",
> someone will ignore this and Bad Things (tm) happen.  Is strdup ever
> used such performance critical code that the extra check would hurt?
> 
> Apart from that, well done.


Rusty created this patch, a long time ago.  :)

	Jeff



