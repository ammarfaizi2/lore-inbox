Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265951AbUFIU3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUFIU3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUFIU3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:29:46 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:19156 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S265939AbUFIU3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:29:34 -0400
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
From: Alex Williamson <alex.williamson@hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <20040609130001.37a88da1.davem@redhat.com>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
	 <1086805676.4288.16.camel@tdi>  <20040609130001.37a88da1.davem@redhat.com>
Content-Type: text/plain
Organization: LOSL
Message-Id: <1086812976.4288.50.camel@tdi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 14:29:36 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 14:00, David S. Miller wrote:
> On Wed, 09 Jun 2004 12:27:56 -0600
> Alex Williamson <alex.williamson@hp.com> wrote:
> 
> > http://marc.theaimsgroup.com/?l=netfilter-devel&m=107814727803971&w=2
> 
> How can you legitimately change this structure?  It's an exported
> userland interface, if you change it all the applications will
> stop working.
> 

   Which is probably why the patch never went anywhere.  There's
certainly an alignment issue in the usage of the struct arpt_arp in the
code snippet Christoph pointed out.  Sounds like it'd be better to fix
the usage than the structure alignment.

	Alex

