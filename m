Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311631AbSCNOqg>; Thu, 14 Mar 2002 09:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311632AbSCNOq2>; Thu, 14 Mar 2002 09:46:28 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31888 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311631AbSCNOqK>; Thu, 14 Mar 2002 09:46:10 -0500
Date: Thu, 14 Mar 2002 14:46:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tigran Aivazian <Tigran.Aivazian@veritas.com>, kraxel@bytesex.org,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
In-Reply-To: <E16lVkh-0000oW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0203141436150.1153-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Alan Cox wrote:
> 
> Similarly the PAE/non-PAE thing is a red herring. Given that even basic
> data types change size on pae no module is going to be magically pae/non-pae
> clean if its binary only.

Few modules take an interest in ptes, that's as it should be, and so
few modules build to different binaries with CONFIX_X86_PAE off or on
(modulo module versions).  I love vmalloc_to_page because it takes pte
dependence out of a group of modules which really had no interest in
ptes in the first place.  Less false grep hits when searching the tree!

Hugh

