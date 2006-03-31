Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWCaQAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWCaQAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWCaQAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:00:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:12710 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751391AbWCaQAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:00:23 -0500
From: Andi Kleen <ak@suse.de>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] avoid unaligned access when accessing poll stack
Date: Fri, 31 Mar 2006 18:00:19 +0200
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <yq0sloytyj5.fsf@jaguar.mkp.net>
In-Reply-To: <yq0sloytyj5.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311800.19364.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 17:38, Jes Sorensen wrote:
> Hi,
> 
> Patch 70674f95c0a2ea694d5c39f4e514f538a09be36f
>   [PATCH] Optimize select/poll by putting small data sets on the stack
> resulted in the poll stack being 4-byte aligned on 64-bit
> architectures, causing misaligned accesses to elements in the array.
> 
> This patch fixes it by declaring the stack in terms of 'long' instead
> of 'char'.

You should do that for poll too then.

-Andi
