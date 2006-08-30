Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWH3I0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWH3I0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWH3I0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:26:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751119AbWH3I0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:26:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <44F4ADD7.4020604@s5r6.in-berlin.de> 
References: <44F4ADD7.4020604@s5r6.in-berlin.de>  <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com> <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com> 
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 09:25:54 +0100
Message-ID: <18771.1156926354@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> What about this?
> 
>  	depends on USB
> +	select BLOCK
>  	select SCSI

That means you can't disable BLOCK either unless you can figure out that you
need to turn off USB_STORAGE.  The config client won't tell you, you have to
go trawling the Kconfig files.

David
