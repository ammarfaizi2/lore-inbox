Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbVG3Psl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbVG3Psl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVG3Psl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:48:41 -0400
Received: from graphe.net ([209.204.138.32]:1964 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262985AbVG3Psk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:48:40 -0400
Date: Sat, 30 Jul 2005 08:48:39 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050729225432.63b3dfb0.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0507300844010.24809@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729225432.63b3dfb0.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Paul Jackson wrote:

> Once we have a clear description of this syntax in the record,
> I anticipate raising as an issue that this syntax does not have a
> single integer or string token value per file (or at most, an array
> or list of comparable integer values).

The current patch only outputs the memory policy via
smaps/emaps. However, this could be construet as a single string
describing the policy.

>From my earlier post:

default                 -> Reset allocation policy to default
prefer=<node>           -> Prefer allocation on specified node
interleave={nodelist}   -> Interleaved allocation on the given nodes
bind={zonelist}         -> Restrict allocation to the specified zones.

Zones are specified by either only providing the node number or using the
notation zone/name. I.e. 3/normal 1/high 0/dma etc.
