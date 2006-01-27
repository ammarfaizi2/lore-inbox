Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWA0WUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWA0WUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWA0WUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:20:22 -0500
Received: from pat.uio.no ([129.240.130.16]:16089 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750782AbWA0WUW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:20:22 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060127204158.GA4754@hardeman.nu>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com>
	 <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu>
Content-Type: text/plain; charset=utf-8
Date: Fri, 27 Jan 2006 17:19:45 -0500
Message-Id: <1138400385.8770.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.448, required 12,
	autolearn=disabled, AWL 1.36, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 21:41 +0100, David Härdeman wrote:

> For example, a backup daemon which wishes to store the backup on another 
> host using ssh. Usually this is solved by storing an unencrypted key in 
> the fs or by providing a connection to a ssh-agent which has been 
> preloaded with the proper key(s). Both are quite inelegant solutions. 
> With the in-kernel support, the daemon can request the key using the 
> request_key call, and (provided proper scripts are written), the user 
> who controls the relevant key can supply it. This in turn means that the 
> backup daemon can sign using the key and read its public parts but not 
> the private key.

...but why would you want such a daemon to live in the kernel in the
first place? A backup application might perhaps need some kernel support
in order to ensure filesystem consistency, but that does not mean that
moving the entire daemon into the kernel is a good idea.

Cheers,
  Trond

