Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUHTHzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUHTHzh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHTHzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:55:37 -0400
Received: from mail1.kontent.de ([81.88.34.36]:8870 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263664AbUHTHzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:55:32 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: PF_MEMALLOC in 2.6
Date: Fri, 20 Aug 2004 09:56:50 +0200
User-Agent: KMail/1.6.2
Cc: Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408192025.53536.oliver@neukum.org> <412563F6.1080202@yahoo.com.au>
In-Reply-To: <412563F6.1080202@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408200956.50972.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 20. August 2004 04:37 schrieb Nick Piggin:
> So if this thing allocates memory on behalf of a read request, then
> it is basically a bug. In practice you could probably get away with
> servicing all writes with PF_MEMALLOC, however that could still lead
> to situations where it consumes all your low memory on behalf of
> highmem IO (though perhaps this won't deadlock if that memory is
> going to be released as a matter of course?)
> 
> Another thing, having it always use PF_MEMALLOC means it can easily
> wipe out the GFP_ATOMIC reserve.
> 
> So I'd say try to find a way to only use PF_MEMALLOC on behalf of
> a PF_MEMALLOC thread or use a mempool or something.

Then the SCSI layer should pass down the flag.

	Regards
		Oliver
