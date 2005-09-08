Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVIHQmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVIHQmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVIHQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:42:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964891AbVIHQmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:42:07 -0400
Date: Thu, 8 Sep 2005 17:42:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "'hch@lst.de'" <hch@lst.de>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       "Patro, Sumant" <sumantp@COS1.co.lsil.com>,
       "Kolli, Neela Syam" <knsyam@lsil.com>
Subject: Re: FW: [Fwd: Re: [PATCH scsi-misc 2/2] megaraid_sas: LSI Logic MegaR AID SAS RA ID D river]
Message-ID: <20050908164203.GA13693@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"'hch@lst.de'" <hch@lst.de>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	'James Bottomley' <James.Bottomley@SteelEye.com>,
	Andrew Morton <akpm@osdl.org>,
	"'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
	"Patro, Sumant" <sumantp@COS1.co.lsil.com>,
	"Kolli, Neela Syam" <knsyam@lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57060CD126@exa-atlanta> <20050906133033.GA30721@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906133033.GA30721@lst.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 03:30:33PM +0200, 'hch@lst.de' wrote:
> It's still wrapped, unfortunately.  Let's retry as an attachment.
> Anyway, I think we can put the patch in now.  I have a few more really
> small things that I'd like to address, I will submit patches as soon
> as I have a codebase that I can create patches against.

I need a trivial one-liner to get it to compile on ppc64, see below.
With that additional patch I think it should go in.


Index: scsi-misc-2.6/drivers/scsi/megaraid/megaraid_sas.c
===================================================================
--- scsi-misc-2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2005-09-08 18:50:20.000000000 +0200
+++ scsi-misc-2.6/drivers/scsi/megaraid/megaraid_sas.c	2005-09-08 18:51:49.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/uio.h>
+#include <linux/compat.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
