Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUG3Cgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUG3Cgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUG3Cgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:36:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35295 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264936AbUG3Cgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:36:40 -0400
Date: Thu, 29 Jul 2004 19:36:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Robert White" <rwhite@casabyte.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
Message-Id: <20040729193637.36d018a5.davem@redhat.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAsIVuAS+Wekm4zD6W7LtKswEAAAAA@casabyte.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAsIVuAS+Wekm4zD6W7LtKswEAAAAA@casabyte.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Turn off NAGLE, and flip TCP_CORK on and off around the sequences.
