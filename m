Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265361AbUF2CQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbUF2CQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 22:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUF2CQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 22:16:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19617 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265361AbUF2CP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 22:15:58 -0400
Date: Mon, 28 Jun 2004 19:15:45 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Robert White" <rwhite@casabyte.com>
Cc: oliver@neukum.org, scott@timesys.com, zaitcev@redhat.com, greg@kroah.com,
       arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040628191545.7a298bc3.davem@redhat.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdh8B1uF8jku6cyB2zk3ojwEAAAAA@casabyte.com>
References: <20040628140343.572a0944.davem@redhat.com>
	<!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdh8B1uF8jku6cyB2zk3ojwEAAAAA@casabyte.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 18:54:46 -0700
"Robert White" <rwhite@casabyte.com> wrote:

> The below makes no sense to me...  Nothing in the definition of struct bar{} (which
> is not packed) infers (top me) in the slightest that foo should be unnaturally
> aligned within it.

First of all, it is what the compiler does and has done since the
__packed__ attribute was added.

Second of all, you are asking it to "PACK" the structure, this includes
any place you place it within other data objects.  It becomes an N-byte
blob that has no alignment constraints must be placed exactly where it
is declared.

I am growing very tired of this thread.
