Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVIUV2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVIUV2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVIUV2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:28:48 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:15624 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964822AbVIUV2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:28:48 -0400
Date: Wed, 21 Sep 2005 16:52:27 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 08/10] uml: Fix GFP_ flags usage
Message-ID: <20050921205227.GC9918@ccure.user-mode-linux.org>
References: <200509211923.21861.blaisorblade@yahoo.it> <20050921172920.10219.29856.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921172920.10219.29856.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 07:29:21PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> -	if(atomic) flags |= GFP_ATOMIC;
> +	if (atomic)
> +		flags = GFP_ATOMIC;

We should take a careful look at where this is called from, and see if we
can get rid of the atomic business altogether.

				Jeff
