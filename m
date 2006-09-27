Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWI0MEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWI0MEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWI0MEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:04:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:51107 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030203AbWI0MEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:04:23 -0400
From: Andi Kleen <ak@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] x86: Add portable getcpu call
Date: Wed, 27 Sep 2006 14:04:09 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <200609262300.k8QN06dD013707@hera.kernel.org> <20060927113739.GB6872@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060927113739.GB6872@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271404.09621.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> So this means that the contents of getcpu_cache will look completely
> different if a process runs in 32bit mode or 64bit mode. Even if you're
> saying "user programs should not..." this looks odd to me.
> Is this really on purpose and do you really think that no user space
> application will ever rely on the format of getcpu_cache?

The vsyscalls do, but if anything else does it deserves breaking.
In the user headers it will also be just a array blob.

I was considering to xor it with a random value to bring the point across
more strongly, but then didn't do it. Do you think I should? 

-Andi
