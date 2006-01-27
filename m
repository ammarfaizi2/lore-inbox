Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWA0J2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWA0J2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWA0J2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:28:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22670 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932438AbWA0J2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:28:19 -0500
Date: Fri, 27 Jan 2006 09:28:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David H?rdeman <david@2gen.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@linux-nfs.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060127092817.GB24362@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David H?rdeman <david@2gen.com>, linux-kernel@vger.kernel.org,
	dhowells@redhat.com, keyrings@linux-nfs.org
References: <1138312694656@2gen.com> <1138312695665@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138312695665@2gen.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 10:58:15PM +0100, David H?rdeman wrote:
> 
> Adds the multi-precision-integer maths library which was originally taken
> from GnuPG and ported to the kernel by (among others) David Howells.
> This version is taken from Fedora kernel 2.6.15-1.1871_FC5.

This is ugly as hell.  If we decided to add it it really needs a major
cleanup, fitting into linux style and removal of unused functionality,
the assembly bits needs to move to an asm/ header, etc.

But to be honest I'd say anything that requires bigints shouldn't go into
the kernel at all.  Could someone explain why they want dsa support in
kernelspace?

