Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWEBHZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWEBHZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWEBHZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:25:44 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51941 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932370AbWEBHZn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:25:43 -0400
In-Reply-To: <20060428174754.GF30532@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] s390: Hypervisor File System
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: akpm@osdl.org, ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF664A393A.3DDB2CB8-ON42257162.0028A565-42257162.0028D14B@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Tue, 2 May 2006 09:25:50 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 02/05/2006 09:26:51
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 04/28/2006 07:47:54 PM:

> On Fri, 28 April 2006 19:37:08 +0200, Michael Holzheu wrote:
> >
> > +static void *diag204_get_buffer(enum diag204_format fmt, int *pages)
> > +{
> > +   void *buf;
> > +
> > +   if (fmt == INFO_SIMPLE)
> > +      *pages = 1;
> > +   else
> > +      *pages = diag204(SUBC_RSI | fmt, 0, 0);
> > +
> > +   if (*pages <= 0)
> > +      return ERR_PTR(-ENOSYS);
>
> Is -ENOSYS the right thing here?  I thought it was for stuff not
> implemented by Linux.  If the hardware or some hypervisor would return
> -ENOSYS, it would be -EIO from Linux' perspective.  But I may be
> wrong.

The only case "diag204(SUBC_RSI | fmt, 0, 0)" can fail is,
if it is not implemented by the hardware. The means
ENOSYS (Function not implemented), doen't it?

Michael

