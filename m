Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWHHOPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWHHOPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWHHOPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:15:01 -0400
Received: from ns.suse.de ([195.135.220.2]:50084 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964893AbWHHOPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:15:00 -0400
From: Andi Kleen <ak@suse.de>
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
Date: Tue, 8 Aug 2006 16:14:47 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
In-Reply-To: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081614.47518.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 16:03, Paolo Giarrusso wrote:
> Andi Kleen <ak@suse.de> ha scritto: 
> 
> > Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:
> > 
> > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > > 
> > > We have never used this flag and recently one user experienced a
> > complaining
> > > warning about this (there was a symbol in the positive half of
> > the address space
> > > IIRC). So fix it.
> > 
> > You can't use kernel cmodel in user space.  It requires running on
> > negative
> > virtual addresses. I would be surprised if it worked for you.
> 
> Argh, yes, I didn't test the patch and I didn't think to it a lot. So
> what about the following bug? Should we hack our own module loader
> based on x86-64's one?

Add the positive relocations to the standard x86-64 loader
and send me a patch. Then you can reuse it.

That should be cleaner than forking it

-Andi
