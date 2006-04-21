Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWDUPgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWDUPgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDUPgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:36:50 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:6458 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750738AbWDUPgt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:36:49 -0400
In-Reply-To: <20060421151800.GB32710@wohnheim.fh-wedel.de>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFC950CF81.274302A0-ON42257157.00555085-42257157.0055C641@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 21 Apr 2006 17:36:53 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 21/04/2006 17:37:48
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 04/21/2006 05:18:00 PM:
> On Fri, 21 April 2006 17:42:28 +0300, Pekka Enberg wrote:
> > On 4/21/06, Michael Holzheu <holzheu@de.ibm.com> wrote:
> > > diff -urpN linux-2.6.16/fs/hypfs/hypfs.h linux-2.6.16-
> hypfs/fs/hypfs/hypfs.h
> > > --- linux-2.6.16/fs/hypfs/hypfs.h   1970-01-01 01:00:00.000000000
+0100
> > > +++ linux-2.6.16-hypfs/fs/hypfs/hypfs.h   2006-04-21 12:56:58.
> 000000000 +0200
> > > +static void inline remove_trailing_blanks(char *string)
> > > +{
> > > +   char *ptr;
> > > +   for (ptr = string + strlen(string) - 1; ptr > string; ptr--) {
> > > +      if (*ptr == ' ')
> > > +         *ptr = 0;
> > > +      else
> > > +         break;
> > > +   }
> > > +}
> >
> > Please consider moving this to lib/string.c and perhaps renaming it to
> > strstrip().
>
> If you do that, could you strip all whitespace?  I have a special
> function to kill a single newline, if present.  Looks to me like those
> two could be combined.

That would be ok for us, since we do not have any newlines
in our strings. I will include this in the next patch!

Michael

