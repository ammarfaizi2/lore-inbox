Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWA2QLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWA2QLr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 11:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWA2QLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 11:11:47 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:42973 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751058AbWA2QLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 11:11:46 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
Date: Sun, 29 Jan 2006 17:11:42 +0100
User-Agent: KMail/1.7.2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
References: <20060128182522.GA31458@havoc.gtf.org>
In-Reply-To: <20060128182522.GA31458@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601291711.43426.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,


On Saturday 28 January 2006 19:25, Jeff Garzik wrote:
> Testing and merge point in Tejun's flood of patches :)  The patch
> below is against current linux-2.6.git.

These "function(unsigned int *classes)" style functions in 
"libata-core.c" worry me somewhat.  Esp. that sometimes you have one class,
sometimes two.
This looks like a bug waiting to happen for me.

Could we somehow get a 

struct ata_classes {
	unsigned int master;
	unsigned int slave;
}

here (or similiar), before this is in used everywhere?

Usage would be function(struct ata_classes *classes) then.


Thanks & Regards

Ingo Oeser


