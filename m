Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUGEUe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUGEUe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUGEUe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:34:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262062AbUGEUez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:34:55 -0400
Date: Mon, 5 Jul 2004 13:32:30 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: segfaults and sockets
Message-Id: <20040705133230.7439d301.davem@redhat.com>
In-Reply-To: <40E9B8D0.10508@blue-labs.org>
References: <40E9B8D0.10508@blue-labs.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jul 2004 16:23:44 -0400
David Ford <david+challenge-response@blue-labs.org> wrote:


> ioctl(5, 0x8906, 0x7fbfffeff0)          = 0
> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> +++ killed by SIGSEGV +++

0x8906 is SIOCGSTAMP, aparently the app isn't using a large enough
structure to capture the timestamp, and the kernel is thus overwriting
some critical part of the stack causing it to crash.
