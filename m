Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUHSSYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUHSSYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHSSYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:24:35 -0400
Received: from mail1.kontent.de ([81.88.34.36]:64461 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267180AbUHSSYd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:24:33 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: PF_MEMALLOC in 2.6
Date: Thu, 19 Aug 2004 20:25:53 +0200
User-Agent: KMail/1.6.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, arjanv@redhat.com, <alan@redhat.com>,
       <greg@kroah.com>, <linux-kernel@vger.kernel.org>, <riel@redhat.com>,
       <sct@redhat.com>
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408192025.53536.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. August 2004 14:41 schrieb Hugh Dickins:
> Fine for it to dip into those reserves when acting on behalf of something
> already PF_MEMALLOC (i.e. try_to_free_pages itself), but not fine for it
> to do so as a matter of course e.g. worst case, doing readahead could
> easily exhaust reserves.  Or, is this thread only used for writing?
> that wouldn't be so bad if so.

All IO going to the actual disk uses the thread. However we usually
don't want to fail IO request due to low memory.

	Regards
		Oliver
