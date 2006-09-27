Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWI0Mnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWI0Mnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWI0Mnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:43:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:44417 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030202AbWI0Mnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:43:45 -0400
From: Andi Kleen <ak@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] x86: Add portable getcpu call
Date: Wed, 27 Sep 2006 14:43:39 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <200609262300.k8QN06dD013707@hera.kernel.org> <200609271404.09621.ak@suse.de> <20060927123959.GC6872@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060927123959.GC6872@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271443.39233.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 14:39, Heiko Carstens wrote:
> > > So this means that the contents of getcpu_cache will look completely
> > > different if a process runs in 32bit mode or 64bit mode. Even if you're
> > > saying "user programs should not..." this looks odd to me.
> > > Is this really on purpose and do you really think that no user space
> > > application will ever rely on the format of getcpu_cache?
> > 
> > The vsyscalls do, but if anything else does it deserves breaking.
> > In the user headers it will also be just a array blob.
> 
> Ah, ok. The blob thing is the part I missed then.

Hmm, perhaps it's better to do that in the standard kernel headers.

-Andi
