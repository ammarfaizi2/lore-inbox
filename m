Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTKEELe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 23:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTKEELe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 23:11:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262736AbTKEELd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 23:11:33 -0500
Date: Tue, 4 Nov 2003 23:12:30 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: David T Hollis <dhollis@davehollis.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Oops in __xfrm4_state_lookup when setting up an IPSEC tunnel
In-Reply-To: <3FA8245B.8030302@davehollis.com>
Message-ID: <Xine.LNX.4.44.0311042304070.12463-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003, David T Hollis wrote:

> Both firewalls are RedHat 9 based installs, running stock 2.6.0-test9 
> kernels (note the variance on bk7 and bk9).  Both are running Shorewall 
> 1.4.7c to setup iptables/netfilter firewalling.

Nothing obvious has changed between these snapshots which would 
cause this.  Are the filtering rules the same at each gateway?

Are you able to reproduce the problem without any filtering rules?

> 
> If I configure the SAD and SPDs on gw2, than setup them up on gw1, gw2 
> Oops hard on __xfrm4_state_lookup.  I have not yet hand copied the 
> entire dump but have the initial pertinent
> info:
> 
> EIP is at __xfrm4_state_lookup+0x6f/0xa0

If you compile your kernel with -g, you should be able to find the 
corresponding line of code (e.g. with addr2line).


- James
-- 
James Morris
<jmorris@redhat.com>


