Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbTHYRtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbTHYRtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:49:21 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:21515 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262077AbTHYRtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:49:20 -0400
Date: Mon, 25 Aug 2003 19:49:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Dan Aloni <da-x@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825194918.A1052@pclin040.win.tue.nl>
References: <20030825161435.GB8961@callisto.yi.org> <20030825122532.J10720@devserv.devel.redhat.com> <20030825170530.GB7097@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825170530.GB7097@gtf.org>; from jgarzik@pobox.com on Mon, Aug 25, 2003 at 01:05:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 01:05:30PM -0400, Jeff Garzik wrote:

> > > +char *strdup(const char *s)
> > > +{
> > > +	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
> > > +	if (rv)
> > > +		strcpy(rv, s);
> > > +	return rv;
> > > +}

> Unfortunately Linus doesn't like the strdup cleanup, so I don't see this
> patch going in either :)

When seeing this my objection was: it introduces something with
a well-known name that uses GFP_KERNEL, so is not suitable everywhere -
an invitation to mistakes.

