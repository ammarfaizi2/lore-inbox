Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267243AbUHTPdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267243AbUHTPdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266739AbUHTPdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:33:20 -0400
Received: from mail1.kontent.de ([81.88.34.36]:59855 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267243AbUHTPcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:32:48 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: PF_MEMALLOC in 2.6
Date: Fri, 20 Aug 2004 17:34:10 +0200
User-Agent: KMail/1.6.2
Cc: Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <1092997872.1996.51.camel@sisko.scot.redhat.com>
In-Reply-To: <1092997872.1996.51.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201734.10317.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 20. August 2004 12:31 schrieb Stephen C. Tweedie:
> Hi,
> 
> On Thu, 2004-08-19 at 13:41, Hugh Dickins wrote:
> 
> > Or would it solve the problem at hand, if it made itself PF_MEMALLOC
> > just while servicing a request from a PF_MEMALLOC?
> 
> It's not the PF_* state of the caller who submitted the IO that matters,
> though --- it's the state of all threads _waiting_ on the IO, which may
> be different, and which can change even after the IO has begun.  
> 
> Eg. kswapd does a writepage, the writepage needs to allocate disk space,
> and in doing so tries to access a metadata block which is already
> undergoing IO from a different thread altogether.

Then how do the current SCSI drivers work?

	Regards
			Oliver
