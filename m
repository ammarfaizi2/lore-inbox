Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTEFJZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbTEFJZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:25:53 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:56592 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262483AbTEFJZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:25:52 -0400
Date: Tue, 6 May 2003 10:38:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Horsten <thomas@horsten.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030506103823.B27816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Horsten <thomas@horsten.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.40.0305061034030.8287-100000@jehova.dsm.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.40.0305061034030.8287-100000@jehova.dsm.dk>; from thomas@horsten.com on Tue, May 06, 2003 at 11:16:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 11:16:45AM +0200, Thomas Horsten wrote:
> Hi,
> 
> In 2.4.21-rc1 some inline functions are added to asm-i386/byteorder.h.
> When __STRICT_ANSI__ is defined, __u64 doesn't get defined by
> asm-i386/types.h, but it is used in one of the new inline functions,
> __arch__swab64.
> 
> This causes files that use __STRICT_ANSI__ and include any file that
> relies on byteorder.h to give a compile error:

It's very simple, don't include kernel headers from userland..

