Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265972AbUF2Tyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUF2Tyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266000AbUF2Tyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:54:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45699 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265972AbUF2Ty3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:54:29 -0400
Date: Tue, 29 Jun 2004 12:54:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: shemminger@osdl.org, debi.janos@freemail.hu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629125401.4ca60aa7.davem@redhat.com>
In-Reply-To: <20040629124951.56de307d@dell_ss3.pdx.osdl.net>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	<20040629112256.58828632@dell_ss3.pdx.osdl.net>
	<20040629124951.56de307d@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What's really amusing in those traces is that it is the sender that
is doing the window scaling, not the receiver.  The side doing the
window interpretation for data packet sending is looking at a
non-scaled window.

Boggle...
