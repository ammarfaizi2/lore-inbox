Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUF1WkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUF1WkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUF1WkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:40:22 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:13028 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265144AbUF1WkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:40:18 -0400
Subject: Re: PATCH] dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040628152839.23178136.davem@redhat.com>
References: <1088457050.2004.40.camel@mulgrave> 
	<20040628152839.23178136.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Jun 2004 17:40:06 -0500
Message-Id: <1088462407.2003.54.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-28 at 17:28, David S. Miller wrote:
> Maybe you should tweak the default implementation such that
> something reasonable happens on 64-bit platforms that
> define dma_addr_t as a 32-bit quantity. :-)

Actually, the default implementation should work on these platforms
too.  Since it's impossible to set a mask over 32 bits, then the best
dma_get_required_mask() will do is return a full spread of 32 bits,
since the memory mask is anded with the current dma mask.

James


