Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbULJUC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbULJUC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 15:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbULJUC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 15:02:28 -0500
Received: from soundwarez.org ([217.160.171.123]:65469 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261803AbULJUCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 15:02:21 -0500
Subject: Re: [WISHLIST] IBM HD Shock detection in Linux
From: Kay Sievers <kay.sievers@vrfy.org>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412100339.46246.shawn.starr@rogers.com>
References: <200412100339.46246.shawn.starr@rogers.com>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 21:03:01 +0100
Message-Id: <1102708981.6773.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 03:39 -0500, Shawn Starr wrote:
> > Lee Revell <rlrevell <at> joe-job.com> writes:
> > 
> > > 
> > > On Wed, 2004-12-01 at 13:31 -0500, Shawn Starr wrote:
> > > > While I have seen this feature in XP, It would be nice to have such 
> > > > functionality in Linux. Does anyone know if this is being worked on 
> > > > somewhere?
> > > 
> > > What is it?  What does it do?  How does it work?  Got a link?
> > 
> > It's a motion detector on the motherboard.
> > 
> > Here is an IBM whitepaper:
> >   ftp://ftp.software.ibm.com/pc/pccbbs/mobiles_pdf/aps2mst.pdf

> Where can we find it on the motherboard or probe for it safely?

No idea. Look at shockprf.sys in the Windows driver:

  Shockproof Disk Driver
  Copyright (C) IBM Corp. 2002, 2003
  Autonomic HDD Protection Manager
  IBM Hard Drive Active Protection System

You will find something like that:

  .text:00010409                 push    0Ah
  .text:0001040B                 push    3F6h
  .text:00010410                 call    ds:WRITE_PORT_UCHAR
  ...
  .text:00014661                 push    7
  .text:00014663                 push    2Eh
  .text:00014665                 call    esi ; WRITE_PORT_UCHAR
  ...
  .text:00014672                 push    7
  .text:00014674                 push    2Fh
  .text:00014676                 call    esi ; WRITE_PORT_UCHAR
  ...
  .text:0001467C                 push    60h
  .text:0001467E                 push    2Eh
  .text:00014680                 call    esi ; WRITE_PORT_UCHAR
  ...
  .text:0001482E                 push    1F0h
  .text:00014833                 call    ds:READ_PORT_USHORT

Good luck,
Kay

