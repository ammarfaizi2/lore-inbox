Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUF0FDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUF0FDj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 01:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUF0FDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 01:03:38 -0400
Received: from mail1.kontent.de ([81.88.34.36]:37826 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266243AbUF0FDh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 01:03:37 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: drivers/block/ub.c
Date: Sun, 27 Jun 2004 07:04:36 +0200
User-Agent: KMail/1.6.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270059.04436.oliver@neukum.org> <20040626230801.GF5526@pclin040.win.tue.nl>
In-Reply-To: <20040626230801.GF5526@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406270704.36063.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Juni 2004 01:08 schrieb Andries Brouwer:
> >> Yes, we have macros. Using those macros would not at all be an improvement here.
> > 
> > How do you arrive at that unusual conclusion?
> 
> The above writes clearly and simply what one wants.
> I expect that you propose writing
> 
>         *((u32 *)(cmd->cdb + 2)) = cpu_to_be32(block);
> 
> or some similar unspeakable ugliness.
> If you had something else in mind, please reveal what.

That "ugliness" has the unspeakable advantage of producing sane code
on big endian architectures.
If you want eye candy, then go and use a structured data type rather
than an array of bytes.

	Regards
		Oliver

