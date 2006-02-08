Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWBHSOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWBHSOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWBHSOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:14:34 -0500
Received: from cantor2.suse.de ([195.135.220.15]:47296 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030421AbWBHSOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:14:34 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation
Date: Wed, 8 Feb 2006 19:13:59 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, pj@sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081914.00231.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 19:05, Christoph Lameter wrote:

> This patch adds a check before the out of memory killer is invoked. At that
> point performance considerations do not matter much so we just scan the zonelist
> and reconstruct a list of nodes. If the list of nodes does not contain all
> online nodes then this is a constrained allocation and we should not call
> the OOM killer.

Looks good.

Ok I would have used an noinline function instead of putting the code inline
to prevent register pressure etc. and make it more readable.

-Andi

