Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUF1VCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUF1VCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUF1VCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:02:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47323 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265207AbUF1VBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:01:23 -0400
Date: Mon, 28 Jun 2004 13:59:48 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: scott@timesys.com, oliver@neukum.org, zaitcev@redhat.com, greg@kroah.com,
       arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040628135948.5f8dca8e.davem@redhat.com>
In-Reply-To: <20040628205058.GB8502@one-eyed-alien.net>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406270631.41102.oliver@neukum.org>
	<20040626233423.7d4c1189.davem@redhat.com>
	<200406271242.22490.oliver@neukum.org>
	<20040627142628.34b60c82.davem@redhat.com>
	<20040628141517.GA4311@yoda.timesys>
	<20040628132531.036281b0.davem@redhat.com>
	<20040628205058.GB8502@one-eyed-alien.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 13:50:58 -0700
Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> I guess, in the end, what this comes down to is the fact that we're all
> going to get bitten on the ass when we finally get to a platform where the
> default alignment is 64-bits, which would then (by default) add padding to
> the above structure.

No it would not, see the other email I just sent out.  Even when Alpha's
could not address smaller-than-word quantities with load/store instructions,
it _DID NOT_ pad such elements in it's ABI defined structure layout rules.
It did word loads, and shift+mask'd out the elements it wanted as needed.
