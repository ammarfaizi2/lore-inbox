Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbTEFJh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTEFJh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:37:26 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:64528 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262485AbTEFJhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:37:25 -0400
Date: Tue, 6 May 2003 10:49:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Horsten <thomas@horsten.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030506104956.A29357@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Horsten <thomas@horsten.com>, linux-kernel@vger.kernel.org
References: <20030506103823.B27816@infradead.org> <Pine.LNX.4.40.0305061146050.8287-100000@jehova.dsm.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.40.0305061146050.8287-100000@jehova.dsm.dk>; from thomas@horsten.com on Tue, May 06, 2003 at 11:47:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 11:47:55AM +0200, Thomas Horsten wrote:
> What would you suggest as an alternative source for the constants in
> linux/cdrom.h when direct CD-ROM access is required (e.g. for audio
> ripping)?

A sanitzed copy of the kernel headers as e.g. in Red Hat's glibc-kerenheaders
package.  In either case cdrom.h should not need <asm/byteorder.h>

> In any case, if the __STRICT_ANSI__ conditional is there in types.h, it
> should be there in byteorder.h as well.

I don't agree with you in principle, but as this is 2.4 it's probably
better to just add it.  Would you mind sending Marcelo a patch?

