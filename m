Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUF0KmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUF0KmL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 06:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUF0Klb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 06:41:31 -0400
Received: from mail1.kontent.de ([81.88.34.36]:60638 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261875AbUF0Kl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 06:41:28 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: drivers/block/ub.c
Date: Sun, 27 Jun 2004 12:42:21 +0200
User-Agent: KMail/1.6.2
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270631.41102.oliver@neukum.org> <20040626233423.7d4c1189.davem@redhat.com>
In-Reply-To: <20040626233423.7d4c1189.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406271242.22490.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Juni 2004 08:34 schrieb David S. Miller:
> On Sun, 27 Jun 2004 06:31:40 +0200
> Oliver Neukum <oliver@neukum.org> wrote:
> 
> > Am Sonntag, 27. Juni 2004 01:20 schrieb David S. Miller:
> > > A ten-fold increase in code size just to access any member
> > > of the structure.
> > > 
> > > I think you have no idea how astronomically inefficient the code is
> > > which gets generated when you add the packed attribute to a structure.
> > 
> > Are you saying that gcc will generate other code with packed even if
> > packed does not change the layout of the structure in question?
> 
> That's correct, because the packed attribute also means that the alignment
> of any particular instance of the structure is not guanrenteed.

OK, then it shouldn't be used in this case. However, shouldn't we have
an attribute like __nopadding__ which does exactly that?

	Regards
		Oliver
