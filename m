Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSBGM4H>; Thu, 7 Feb 2002 07:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289384AbSBGMz5>; Thu, 7 Feb 2002 07:55:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:49533 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288614AbSBGMzy>; Thu, 7 Feb 2002 07:55:54 -0500
Date: Thu, 7 Feb 2002 12:58:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "David S. Miller" <davem@redhat.com>
cc: riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk, Ulrich.Weigand@de.ibm.com,
        zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: The IBM order relaxation patch
In-Reply-To: <20020207.042903.71864726.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0202071251240.1062-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, David S. Miller wrote:
> 
> BTW, in checking this out it seems current->allocation_order is only
> set and never checked anywhere.

Yes, the "local_pages" interaction between __free_pages_ok and
balance_classzone is in a half-baked state in the mainline tree,
I think Linus backed out some of what Andrea intended: the -aa tree
makes more sense there (where "allocation_order" is "local_pages.order").

Hugh

