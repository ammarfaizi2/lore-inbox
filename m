Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWFUQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWFUQMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWFUQMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:12:34 -0400
Received: from gw.openss7.com ([142.179.199.224]:47025 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750796AbWFUQMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:12:31 -0400
Date: Wed, 21 Jun 2006 10:12:30 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 0/8] Inode diet v2
Message-ID: <20060621101230.A20623@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
References: <20060621125146.508341000@candygram.thunk.org> <20060621084217.B7834@openss7.org> <1150906010.3057.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1150906010.3057.45.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Wed, Jun 21, 2006 at 06:06:50PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

On Wed, 21 Jun 2006, Arjan van de Ven wrote:
> 
> for the inode slab it would very much make sense to tell the slab
> allocator to not do any kind of cacheline alignment at all, just because
> of the wasted space...

As the objects are an order of magnitude larger than the L1 cache slot,
it is fitting an integer multiple into a slab that is the limiting factor,
not really cacheline alignment.

