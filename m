Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbTIDWUe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbTIDWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:20:34 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:32903 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S265619AbTIDWU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:20:27 -0400
Date: Thu, 04 Sep 2003 16:22:16 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: John Cherry <cherry@osdl.org>, trivial@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL][PATCH] fix parallel builds for aic7xxx]
Message-ID: <59600000.1062714135@aslan.btc.adaptec.com>
In-Reply-To: <1062698342.9322.73.camel@cherrytest.pdx.osdl.net>
References: <1062698342.9322.73.camel@cherrytest.pdx.osdl.net>
X-Mailer: Mulberry/3.1.0b6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> My compile regression scripts were getting random build failures for
> aic7xxx.  The two makefiles could not handle parallel build. 
> Occasionally they would succeed...timing dependent.  The following two
> patches fix this.
> 
> Part 1 - drivers/scsi/aic7xxx/Makefile

I don't understand this patch.  It places the .seq file as a target
that is rebuilt by invoking the assembler.  The .seq file is not
a generated file.

Can you explain the nature of the failure and why you believe this
fixes the problem (other than - "it seems to work with my testing").
The previous Makefile appears to be perfectly valid.

> Part 2 - drivers/scsi/aic7xxx/aicasm/Makefile

This also doesn't make a lot of sense to me.  Is gmake so
dumb as to not be able to understand that the invocation of
a single target may satisfy multiple dependencies?

--
Justin

