Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTEMWSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTEMWSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:18:18 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:47235 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id S263704AbTEMWQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:16:54 -0400
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support only
From: Nathan Neulinger <nneul@umr.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       openafs-devel@openafs.org
In-Reply-To: <20030513213759.A9244@infradead.org>
References: <8943.1052843591@warthog.warthog>
	 <20030513213759.A9244@infradead.org>
Content-Type: text/plain
Organization: University of Missouri - Rolla
Message-Id: <1052864839.20037.2.camel@nneul-laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 May 2003 17:27:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static kmem_cache_t *vfs_token_cache;
> > +static kmem_cache_t *vfs_pag_cache;
> 
> How many of those will be around for a typical AFS client?  I have the vague
> feeling the slabs are overkill..

What's a "typical client"?

I have machines that typically have 0 pags and tokens in kernel, and I
have machines that typically have a few hundred to a thousand.

Per pag on most clients will only have a single token, but number of
pags will depend totally on the nature of the machine. 

I also have machines that have a few hundred pags around that don't have
any tokens in them, but could at any time.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216

