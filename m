Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbTHXPCw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbTHXPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 11:02:52 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:45833 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261167AbTHXPCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 11:02:50 -0400
Date: Sun, 24 Aug 2003 16:02:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, sds@epoch.ncsc.mil
Subject: Re: selinux build failure
Message-ID: <20030824160245.A18526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org, sds@epoch.ncsc.mil
References: <33070.4.4.25.4.1061612835.squirrel@www.osdl.org> <Mutt.LNX.4.44.0308250048080.21789-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0308250048080.21789-100000@excalibur.intercode.com.au>; from jmorris@redhat.com on Mon, Aug 25, 2003 at 12:49:52AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 12:49:52AM +1000, James Morris wrote:
> > see a good way to #include asm/compat.h, nor is it available for all
> > processor architectures.
> 
> It is available via <linux/compat.h> if CONFIG_COMPAT is defined.
> 
> Does the patch below fix this for you?

Argg, this is b0rked.  {asm,linux}/compat.h are for the 32bit compatiblity
code.  64bit arches don't have fcntl64 - see the #if BITS_PER_LONG == 32
around sys_fcntl64 in fcntl.c..

