Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWAKJtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWAKJtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWAKJtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:49:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751305AbWAKJtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:49:11 -0500
Date: Wed, 11 Jan 2006 04:48:54 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: drepper@redhat.com, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
Message-ID: <20060111094854.GK7768@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060111.000020.25886635.davem@davemloft.net> <1136967192.2929.6.camel@laptopd505.fenrus.org> <43C4C37B.9020801@redhat.com> <20060111.004418.92939254.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111.004418.92939254.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 12:44:18AM -0800, David S. Miller wrote:
> From: Ulrich Drepper <drepper@redhat.com>
> Date: Wed, 11 Jan 2006 00:36:11 -0800
> 
> > Anyway, candidates for this kind of transformation:
> > 
> > net/ipx/af_ipx.c:1450:  if (ntohs(addr->sipx_port) <
> > IPX_MIN_EPHEMERAL_SOCKET &&
> 
> Does it work for comparisons?  F.e.:
> 
>      if (val < ntohs(VAL))

No, only for ==, !=, &, |, ~.

	Jakub
