Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVEQOe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVEQOe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEQOe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:34:57 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:19893 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261522AbVEQOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:34:50 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dino@in.ibm.com, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050517002908.005a9ba7.akpm@osdl.org>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com>  <20050517002908.005a9ba7.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 17 May 2005 09:34:25 -0500
Message-Id: <1116340465.4989.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 00:29 -0700, Andrew Morton wrote:
> Better cc linux-scsi.

Always a wise thing to do for SCSI failure reports.

> >  target0:0:1: Ending Domain Validation
> > (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers   <============
> > scsi0:0:15:0: Attempting to queue an ABORT message
> > CDB: 0x12 0x0 0x0 0x0 0x36 0x0

Actually, this isn't a me too.  The previous one looks like some strange
DV failure.  This is a problem with the initial inquiry.  What's the
device at target 15?

James


