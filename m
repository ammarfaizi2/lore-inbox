Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbTFEMfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbTFEMfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:35:34 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:38911 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264657AbTFEMfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:35:33 -0400
Date: Thu, 05 Jun 2003 08:42:22 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: Re: /proc/bus/pci
In-reply-to: <20030605.051607.71090313.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: albert@users.sourceforge.net, torvalds@transmeta.com,
       linux-kernel <linux-kernel@vger.kernel.org>, bcollins@debian.org,
       wli@holomorphy.com, tom_gall@vnet.ibm.com, anton@samba.org
Message-id: <1054816942.22104.6162.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0306042117440.2761-100000@home.transmeta.com>
 <1054814759.22103.6114.camel@cube> <20030605.051607.71090313.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 08:16, David S. Miller wrote:
>    From: Albert Cahalan <albert@users.sourceforge.net>
>    Date: Thu, 05 Jun 2003 08:05:59 -0400
>    
>    To make this clear, mmap() on bar0 would get you
>    a mapping of that BAR.
>    
> We have a way to portably mmap() PCI devices using just the device
> node.

The "device node"? You mean stuff in /proc, right?

> If you make this new method, you might have to define a whole
> new set of arch level support hooks.

No. You explained why not:

> What I'm saying is, we should reuse all of this code we have
> to support mmap()'ing PCI devices properly now (via procfs
> device node files).

The existing per-arch code looks like it would work.
At worst, an offset (probably already a #define somewhere)
might need to be added.

Pushing a MAP_MMIO through to the per-arch code
might be slightly more involved. I can do PowerPC
and x86 at least, if it comes to that.



