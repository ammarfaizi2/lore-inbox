Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWDUPSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWDUPSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWDUPSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:18:18 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:14724 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932350AbWDUPSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:18:17 -0400
Date: Fri, 21 Apr 2006 17:18:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Michael Holzheu <holzheu@de.ibm.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Message-ID: <20060421151800.GB32710@wohnheim.fh-wedel.de>
References: <20060421133541.37002378.holzheu@de.ibm.com> <84144f020604210742j69222654s5ec68f34ea96999c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84144f020604210742j69222654s5ec68f34ea96999c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 April 2006 17:42:28 +0300, Pekka Enberg wrote:
> On 4/21/06, Michael Holzheu <holzheu@de.ibm.com> wrote:
> > diff -urpN linux-2.6.16/fs/hypfs/hypfs.h linux-2.6.16-hypfs/fs/hypfs/hypfs.h
> > --- linux-2.6.16/fs/hypfs/hypfs.h	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.16-hypfs/fs/hypfs/hypfs.h	2006-04-21 12:56:58.000000000 +0200
> > +static void inline remove_trailing_blanks(char *string)
> > +{
> > +	char *ptr;
> > +	for (ptr = string + strlen(string) - 1; ptr > string; ptr--) {
> > +		if (*ptr == ' ')
> > +			*ptr = 0;
> > +		else
> > +			break;
> > +	}
> > +}
> 
> Please consider moving this to lib/string.c and perhaps renaming it to
> strstrip().

If you do that, could you strip all whitespace?  I have a special
function to kill a single newline, if present.  Looks to me like those
two could be combined.

Jörn

-- 
The wise man seeks everything in himself; the ignorant man tries to get
everything from somebody else.
-- unknown
