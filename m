Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVH2RGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVH2RGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVH2RGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:06:06 -0400
Received: from verein.lst.de ([213.95.11.210]:21965 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750806AbVH2RGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:06:04 -0400
Date: Mon, 29 Aug 2005 19:05:50 +0200
From: "'Christoph Hellwig'" <hch@lst.de>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'Christoph Hellwig'" <hch@lst.de>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH scsi-misc 2/2] megaraid_sas: LSI Logic MegaRAID SAS RAID D river
Message-ID: <20050829170550.GA21128@lst.de>
References: <0E3FA95632D6D047BA649F95DAB60E57060CD100@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CD100@exa-atlanta>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks pretty good to me.  Small issues I've identified:

 - what do you need the hba_count attribute for?  This should be
   implementable in userspace pretty easily by iterating of all
   devices of the scsi_host class that are attached to the driver
 - the ->queuecommand cleanup patch I sent you a awhile ago doesn't
   seem to be applied
 - there's quite a lot of slightly odd formating, it would be nice
   if you could run the code through scripts/Lindent.

If you could sent out an unmangled patch (even as attachment or on
LSI's ftp side) I'd like to take another, closer look.

