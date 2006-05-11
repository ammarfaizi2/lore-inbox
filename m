Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWEKLns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWEKLns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWEKLns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:43:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10958 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030235AbWEKLnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:43:47 -0400
To: linuxram@us.ibm.com (Ram Pai)
Cc: agruen@suse.de, akpm@osdl.org, arjan@infradead.org, bunk@stusta.de,
       greg@kroah.com, hch@infradead.org, jbeulich@novell.com,
       linux-kernel@vger.kernel.org, mathur@us.ibm.com
Subject: Re: [PATCH 4/4] KBUILD: export-symbol usage report generator
References: <20060510235546.8A006470034@localhost>
From: Andi Kleen <ak@suse.de>
Date: 11 May 2006 13:43:27 +0200
In-Reply-To: <20060510235546.8A006470034@localhost>
Message-ID: <p73r7307pnk.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxram@us.ibm.com (Ram Pai) writes:

> From: Ram Pai <linuxram@us.ibm.com>
> 
> The following patch provides the ability to generate a report of
>      (1) All the exported symbols and their in-kernel-module usage count
>      (2) For each module, lists the modules and their exported symbols, on
>                 which it depends.

Very nice.

One thing I always wanted to see was a more focussed EXPORT_SYMBOL.

A lot of symbols are only exported for a single other module (e.g. most
of the networking exports are for IPv6) but are actually internal 
and shouldn't be messed with by other modules. It would be nice
if name spaces could be defined that say "this export is only for 
modules in this name space" and then e.g. have IPv6 be in the TCPINTERNALS
name space and nobody else.

I think adding something like this could clean up the bewildering
jungle of exports greatly.

_GPL is kind of like that already, but it is not fine grained enough.

-Andi
