Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUE3GnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUE3GnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 02:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUE3GnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 02:43:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40858 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261791AbUE3GnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 02:43:04 -0400
Date: Sat, 29 May 2004 23:42:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix typo in pmac_zilog
Message-Id: <20040529234258.42a2dc64.davem@redhat.com>
In-Reply-To: <1085715655.6320.138.camel@gaston>
References: <1085715655.6320.138.camel@gaston>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004 13:40:55 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This patch fixes a typo preventing channel B from working on the Rx
> path of pmac zilog (never calling tty_flip_*). I think I never tested
> channel B :)

Ben, why do you do the tty_flip_buffer_push() outside of
the port lock?  Just because it's expensive and therefore
this decreases the lock hold time, or is there some deadlock
issue?

Sounds like I should make the change to sunzilog :-)
