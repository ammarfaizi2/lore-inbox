Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWH3NKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWH3NKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWH3NKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:10:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:52892 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751007AbWH3NKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:10:15 -0400
Subject: Re: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather
	than selecting it [try #6]
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <18044.1156942921@warthog.cambridge.redhat.com>
References: <1156942162.11819.1.camel@kleikamp.austin.ibm.com>
	 <44F4ADD7.4020604@s5r6.in-berlin.de>
	 <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
	 <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com>
	 <18771.1156926354@warthog.cambridge.redhat.com>
	 <44F54FB0.7080203@s5r6.in-berlin.de>
	 <18044.1156942921@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 13:10:12 +0000
Message-Id: <1156943413.11819.8.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 14:02 +0100, David Howells wrote:
> Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> 
> > Would this make more sense?
> > 
> > 	depends on USB && BLOCK
> > 	select SCSI
> 
> That, though, is redundant, since SCSI depends on BLOCK.

Wouldn't this "hide" USB_STORAGE when BLOCK is unselected, but otherwise
ensure that SCSI is enabled if USB_STORAGE is selected?
-- 
David Kleikamp
IBM Linux Technology Center

