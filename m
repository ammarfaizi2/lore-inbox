Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266315AbUFPVdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266315AbUFPVdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUFPVdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:33:53 -0400
Received: from [213.146.154.40] ([213.146.154.40]:23456 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266311AbUFPVdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:33:45 -0400
Date: Wed, 16 Jun 2004 22:33:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040616213343.GA20488@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040616210455.GA13385@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616210455.GA13385@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 05:04:55PM -0400, Alan Cox wrote:
> I've been going through Mark's changes with a fine toothcomb and this merges
> most of them. Its tested on 64bit SMP hardware and seems to be fine. There
> are a couple of Mark's changes I've left out for now but there isnt really
> an easy way to break down the changes further.
> 
> This fixes a whole host of problems including random hangs under high load

Looks mostly good except for the GART iommu ifdef.  That code is bogus for
almost everything but a plain PC and should just be killed.

Does this apply ontop of Marc's ioctl patch?
