Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266167AbUFPEOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUFPEOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUFPEMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:12:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4812 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266154AbUFPELd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:11:33 -0400
Date: Tue, 15 Jun 2004 21:05:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil
Subject: Re: [SELINUX/NET] Fix sock_orphan race.
Message-Id: <20040615210531.2d367db9.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0406151012030.27745-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0406151012030.27745-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004 10:18:59 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> The patch below fixes a race between sock_orphan() and
> selinux_socket_sock_rcv_skb() which can lead to a null pointer deref oops
> under heavy load.  The sk_callback_lock is used in the patch to 
> synchronize access to the incoming socket's inode security state.
> 
> This patch has been under test in the Fedora kernel for over a month 
> without incident.

Applied, thanks.
