Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUF0Gfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUF0Gfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 02:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbUF0Gfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 02:35:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266287AbUF0Gf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 02:35:28 -0400
Date: Sat, 26 Jun 2004 23:34:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040626233423.7d4c1189.davem@redhat.com>
In-Reply-To: <200406270631.41102.oliver@neukum.org>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406270036.14716.oliver@neukum.org>
	<20040626162020.67d661c7.davem@redhat.com>
	<200406270631.41102.oliver@neukum.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 06:31:40 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> Am Sonntag, 27. Juni 2004 01:20 schrieb David S. Miller:
> > A ten-fold increase in code size just to access any member
> > of the structure.
> > 
> > I think you have no idea how astronomically inefficient the code is
> > which gets generated when you add the packed attribute to a structure.
> 
> Are you saying that gcc will generate other code with packed even if
> packed does not change the layout of the structure in question?

That's correct, because the packed attribute also means that the alignment
of any particular instance of the structure is not guanrenteed.
