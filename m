Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWA2TLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWA2TLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWA2TLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:11:09 -0500
Received: from pat.uio.no ([129.240.130.16]:59533 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751117AbWA2TLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:11:06 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer 
	maths	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Dax Kelson <dax@gurulabs.com>
Cc: "\"David" =?ISO-8859-1?Q?H=E4rdeman=22?= <david@2gen.com>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <406-SnapperMsg827D11E1C002BEC0@[70.7.65.98]>
References: <20060127092817.GB24362@infradead.org>  <1138312694656@2gen.com>
	 <1138312695665@2gen.com>  <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	 <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu>
	 <1138552702.8711.12.camel@lade.trondhjem.org>
	 <406-SnapperMsg827D11E1C002BEC0@[70.7.65.98]>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 14:10:46 -0500
Message-Id: <1138561846.8711.33.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.059, required 12,
	autolearn=disabled, AWL 1.75, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 11:49 -0700, Dax Kelson wrote:

> >Has anyone tried to look for simpler signing mechanisms that make use of
> >the crypto algorithms that are already in the kernel?
> 
> Maybe you meant something else, but history has shown that 'rolling your own' mechanism is a bad idea.
> 
> Are there even any suitable algorithms in the kernel??

I'm suggesting that if the only real problem that dsa in the kernel
solves is module signing, then perhaps one can simplify the problem.

For instance, if instead of going for a general signing mechanism in the
kernel that will take any old module and verify it, you define a
particular binary as being trusted, and then devise a signature that the
kernel can check (even the SHA-1 of the binary image might be
sufficient).
The object would be to give the kernel a trusted program that can check
module signatures on its behalf.

Cheers,
  Trond

