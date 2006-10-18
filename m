Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWJRK7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWJRK7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWJRK7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:59:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:51860 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030189AbWJRK7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:59:11 -0400
From: Andi Kleen <ak@suse.de>
To: "bibo,mao" <bibo.mao@intel.com>
Subject: Re: [PATCH] x86_64 add NX mask for PTE entry
Date: Wed, 18 Oct 2006 12:58:45 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <4535F0A4.1090709@intel.com>
In-Reply-To: <4535F0A4.1090709@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181258.45176.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 11:15, bibo,mao wrote:
> Hi,
>     If function change_page_attr_addr calls revert_page to revert
> to original pte value, mk_pte_phys does not mask NX bit. If NX bit
> is set on no NX hardware supported x86_64 machine, there is will
> be RSVD type page fault and system will crash. This patch adds NX
> mask bit for PTE entry.

Hmm, weird. I wonder why that didn't trip up earlier. Did you
actually see that happening? 


-Andi
