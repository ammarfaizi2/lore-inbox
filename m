Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbREULhO>; Mon, 21 May 2001 07:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262489AbREULhE>; Mon, 21 May 2001 07:37:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33409 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262488AbREULgy>;
	Mon, 21 May 2001 07:36:54 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.64978.954038.894838@pizda.ninka.net>
Date: Mon, 21 May 2001 04:36:50 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521130835.A3910@gruyere.muc.suse.de>
In-Reply-To: <20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521112357.A1718@gruyere.muc.suse.de>
	<15112.57377.723591.710628@pizda.ninka.net>
	<20010521114216.A1968@gruyere.muc.suse.de>
	<15112.59192.613218.796909@pizda.ninka.net>
	<20010521122753.A2507@gruyere.muc.suse.de>
	<15112.61258.251051.960811@pizda.ninka.net>
	<20010521124225.A3417@gruyere.muc.suse.de>
	<15112.62483.731973.549006@pizda.ninka.net>
	<20010521130835.A3910@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > How about a new function (pci_nonrepresentable_address() or whatever) 
 > that returns true when page cache contains pages that are not representable
 > physically as void *. On IA32 it would return true only if CONFIG_PAE is 
 > true and there is memory >4GB. 

No, if we're going to change anything, let's do it right.

Sure, you'll make this one check "portable", but the guts of the
main ifdef stuff for DAC support is still there.

I'd rather live with the hackish stuff temporarily, and get this all
cleaned up in one shot when we have a real DAC support API.

Later,
David S. Miller
davem@redhat.com
