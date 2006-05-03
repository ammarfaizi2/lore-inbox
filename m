Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWECNSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWECNSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWECNSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:18:35 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59851 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030191AbWECNSe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:18:34 -0400
In-Reply-To: <20060503130043.GC19537@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] s390: Hypervisor File System
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFF044ED40.56CCD284-ON42257163.0048A5F3-42257163.00491F2C@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 15:18:41 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 15:19:43
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 05/03/2006 03:00:43 PM:
> On Wed, 3 May 2006 14:51:53 +0200, Michael Holzheu wrote:
> > Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 05/03/2006 02:33:39
PM:
> >
> > > Applications will depend on some arcane detail of your format.  They
> > > will depend on exactly five spaces in "foo     bar".  It does not
even
> > > matter if you documented "any amount of whitespace".  The application
> > > knows that it was five spaces and doesn't care.  And once you change
> > > it, the blame will be on you, because you broke existing userspace.
> >
> > Again, logically there is no difference between the two solutions. It
does
> > not matter, if you have one file with:
> >
> > <cpu>
> >     <0>
> >        <onlinetime = 4711>
> >     <\0>
> > <\cpu>
>
> Userspace can make your life hell by depending on indentation via 4
> spaces.  The problem is that you don't necessarily know that it does
> until you managed to change indentation.

Of course! But the convention must be, that If userspace wants to
access the data, it has to use our standard linux
parser. If it accesses the data directly, this is broken.
This ensures, that whitespaces do not matter at all! And as
I said before, if you use the parser, you don't have any
difference compared to the filesystem solution from a logical
perspective.

Michael

