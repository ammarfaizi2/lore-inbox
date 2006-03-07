Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWCGSPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWCGSPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWCGSPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:15:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57564 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751458AbWCGSPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:15:09 -0500
Subject: Re: Memory barriers and spin_unlock safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, ak@suse.de,
       mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <31420.1141753019@warthog.cambridge.redhat.com>
References: <5041.1141417027@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>
	 <32518.1141401780@warthog.cambridge.redhat.com>
	 <1146.1141404346@warthog.cambridge.redhat.com>
	 <31420.1141753019@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Mar 2006 18:18:16 +0000
Message-Id: <1141755496.31814.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 17:36 +0000, David Howells wrote:
> Hmmm... We don't actually have io_wmb()... Should the following be added to
> all archs?
> 
> 	io_mb()
> 	io_rmb()
> 	io_wmb()

What kind of mb/rmb/wmb goes with ioread/iowrite ? It seems we actually
need one that can work out what to do for the general io API ?

