Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUFZWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUFZWfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUFZWfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:35:19 -0400
Received: from mail1.kontent.de ([81.88.34.36]:63414 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266499AbUFZWfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:35:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: drivers/block/ub.c
Date: Sun, 27 Jun 2004 00:36:14 +0200
User-Agent: KMail/1.6.2
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406262356.49275.oliver@neukum.org> <20040626150700.544a4fb4.davem@redhat.com>
In-Reply-To: <20040626150700.544a4fb4.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406270036.14716.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Juni 2004 00:07 schrieb David S. Miller:
> On Sat, 26 Jun 2004 23:56:49 +0200
> Oliver Neukum <oliver@neukum.org> wrote:
> 
> > Unless I am mistaken, this structure is transfered as such over the bus,
> > so IMHO here it is needed.
> 
> That is not the only criterious that needs to be met in order for
> the packed attribute to be required.
> 
> It is needed only if the structure elements are such that gcc will
> not packet them properly on all supported architecutures.  Peter's
> example in his code will be packed properly without the packed
> attribute to the best of my knowledge.

So either it has no effect or it is needed?
Then why take the risk that gcc is changed or an architecture added that
needs it? It seems to be cleaner to me to mark data structures that
must be layed out as specified specially. Safer, too, just in case.

	Regards
		Oliver
