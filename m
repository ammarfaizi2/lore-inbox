Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbTGGG52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbTGGG52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:57:28 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:63240 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266850AbTGGG51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:57:27 -0400
Date: Mon, 7 Jul 2003 08:11:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@intercode.com.au>
Cc: Thomas Spatzier <TSPAT@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
Message-ID: <20030707081159.B1848@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@intercode.com.au>,
	Thomas Spatzier <TSPAT@de.ibm.com>, linux-kernel@vger.kernel.org
References: <OF014BDDD3.522D4623-ONC1256D57.003FFD79-C1256D57.0044F37D@de.ibm.com> <Mutt.LNX.4.44.0307030234400.1298-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0307030234400.1298-100000@excalibur.intercode.com.au>; from jmorris@intercode.com.au on Thu, Jul 03, 2003 at 02:57:30AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 02:57:30AM +1000, James Morris wrote:
> Then, when a caller specifies "aes", crypto_alg_autoload() would first
> check the alias list, giving preference to CRYPTO_ALG_ARCH by default.  
> In this case, it would find aes_z990 and try and load it.  If this fails,
> it continues along the alias list then ultimately falls back to the
> current behavior.

This sounds like the right way to do it.  The question is just whether we
want to put that complicated policy into the kernel or into some userspace
helper.

