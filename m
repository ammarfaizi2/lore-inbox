Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWHISRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWHISRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWHISRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:17:01 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8392 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751152AbWHISRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:17:00 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edgar Toernig <froese@gmx.de>
Cc: Chase Venters <chase.venters@clientec.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <20060809200010.2404895a.froese@gmx.de>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
	 <1155039338.5729.21.camel@localhost.localdomain>
	 <20060809104159.1f1737d3.froese@gmx.de>
	 <1155119999.5729.141.camel@localhost.localdomain>
	 <20060809200010.2404895a.froese@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 19:36:45 +0100
Message-Id: <1155148605.5729.251.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 20:00 +0200, ysgrifennodd Edgar Toernig:
> But anyway, correct me if I'm wrong, revoke (V2) not simply removes the
> pages from the mmaped area as truncating does (the vma stays);  revoke
> seems to completely remove the vma which is clearly a security bug.
> Future mappings may silently get mapped into the area of the revoked
> file without the app noticing it.  It may then hand out data of the new
> file still thinking it's sending the old one.

I agree with that point 100%.


