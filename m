Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWJYRpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWJYRpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 13:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWJYRpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 13:45:41 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:16813 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1161232AbWJYRpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 13:45:41 -0400
Date: Wed, 25 Oct 2006 10:45:40 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Andrew Morton <akpm@osdl.org>
cc: Nigel Cunningham <ncunningham@linuxmail.org>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
In-Reply-To: <20061023095124.7be583ce.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610251044380.19648@twinlark.arctic.org>
References: <1161560896.7438.67.camel@nigel.suspend2.net> <200610231226.03718.rjw@sisk.pl>
 <1161604811.3315.12.camel@nigel.suspend2.net> <20061023095124.7be583ce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Andrew Morton wrote:

> > On Mon, 23 Oct 2006 22:00:11 +1000 Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > If you can only thaw the kernel threads, you can free memory without
> > restarting userspace or deadlocking against a frozen kjournald.
> > 
> 
> kjournald will not participate in writing to swapfiles.
> 
> The situation where we would need this feature is where the loop driver is
> involved in the path-to-disk.  But I doubt if that's a thing we'd want to
> support.

dm-crypt?  that seems like a very important thing to support for suspend 
to disk.

-dean
