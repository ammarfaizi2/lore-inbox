Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUFZWH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUFZWH7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUFZWH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:07:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28834 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266474AbUFZWH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:07:57 -0400
Date: Sat, 26 Jun 2004 15:07:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040626150700.544a4fb4.davem@redhat.com>
In-Reply-To: <200406262356.49275.oliver@neukum.org>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406262235.15688.oliver@neukum.org>
	<20040626144147.5f13cce9.davem@redhat.com>
	<200406262356.49275.oliver@neukum.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004 23:56:49 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> Unless I am mistaken, this structure is transfered as such over the bus,
> so IMHO here it is needed.

That is not the only criterious that needs to be met in order for
the packed attribute to be required.

It is needed only if the structure elements are such that gcc will
not packet them properly on all supported architecutures.  Peter's
example in his code will be packed properly without the packed
attribute to the best of my knowledge.
