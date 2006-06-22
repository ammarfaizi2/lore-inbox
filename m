Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWFVREK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWFVREK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWFVREK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:04:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932548AbWFVREI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:04:08 -0400
Date: Thu, 22 Jun 2006 10:03:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] dm: add exports
Message-Id: <20060622100353.50a7654e.akpm@osdl.org>
In-Reply-To: <20060622135117.GS19222@agk.surrey.redhat.com>
References: <20060621193657.GA4521@agk.surrey.redhat.com>
	<20060621210504.b1f387bd.akpm@osdl.org>
	<20060622135117.GS19222@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 14:51:17 +0100
Alasdair G Kergon <agk@redhat.com> wrote:

> On Wed, Jun 21, 2006 at 09:05:04PM -0700, Andrew Morton wrote:
> > Twenty new exports.  What are they all for?
> 
> The exports correspond to the functionality available to userspace through
> the existing ioctl interface.
> 
> Currently, we only offer an ioctl interface for device-mapper and this is
> unsuitable for any future in-kernel users wishing to make use of
> device-mapper facilities.
> 

Normally we don't export symbols until there's something in-tree which
needs that export.

Occasionally we'll leave a symbol exported when it has no in-tree users,
because it is part of an API which is exported in toto.  But I don't think
that's the case here.

Adding twenty new unused exports is rather a big deal.  Do you have some
new code pending which will use all these?
