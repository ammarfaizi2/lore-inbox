Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264601AbUEDTxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbUEDTxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbUEDTxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:53:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264601AbUEDTxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:53:32 -0400
Date: Tue, 4 May 2004 15:53:26 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Eugene Surovegin <ebs@ebshome.net>
cc: remy.gauguey@mindspeed.com, <linux-crypto@nl.linux.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6 crypto API and HW accelerators
In-Reply-To: <20040504161726.GA25795@gate.ebshome.net>
Message-ID: <Xine.LNX.4.44.0405041542060.8760-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Eugene Surovegin wrote:

> In short, my experience showed that without significant changes in current 
> implementation, e.g. adding async crypto, adding hardware crypto is worth only 
> for relatively slow CPUs, e.g. less than 1Ghz, and even with slow processor 
> overhead can be so big, that short packets are better processed by software 
> path.

Yes, have a look at the OpenBSD paper at 
http://www.openbsd.org/papers/ocf.pdf

Their results show marked performance improvements for larger packets
(even though the packets are making multiple trips across the PCI bus),
and they suggest batching smaller packets.


- James
-- 
James Morris
<jmorris@redhat.com>


