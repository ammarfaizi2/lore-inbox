Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWECPWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWECPWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWECPWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:22:35 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:50216 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965214AbWECPWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:22:34 -0400
In-Reply-To: <1146668286.2661.23.camel@localhost>
Subject: Re: [PATCH] s390: Hypervisor File System
To: mschwid2@de.ibm.com
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF1D1242F6.B128341D-ON42257163.0053988E-42257163.0054799B@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 17:22:41 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 17:23:43
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mschwid2@de.ltcfwd.linux.ibm.com wrote on 05/03/2006 04:58:06 PM:
> On Wed, 2006-05-03 at 16:23 +0200, Michael Holzheu wrote:
> > mschwid2@de.ltcfwd.linux.ibm.com wrote on 05/03/2006 04:17:40 PM:
> > > And the user space then uses the parser only? Is now the parser
> > > interface the "ABI" or the kernel interface that is in turn used by
the
> > > parser? And what happens if somebody comes up with a "better" parser
> > > that does things subtly different?
> >
> > The ABI is not defined by the Parser. You have to specify the
> > tag language, which is part of the ABI. Any parser, which is comliant
> > to the specification of the tag language can be used.
>
> Optimist.

One very last comment: I think for our problem to
ensure consitency of hypervisor data, when an application
always wants to get the complete set of information,
the "one file" solution with a fully specified ASCII
tag language format looks for me to be the easiest way
to implement our solution. And I think, if one decides to
use one file to provide all the information, it is better to
have a standard data format than always invent new
formats. And to use a standard ASCII format is
in my eyes also better than to have a binary interface.

If everybody says, that it is in principal not a good idea
to use one file, than a snapshot mechanism
for filesystems is probably go good method to provide
consitency. And this is definitely not my decission...

Michael

