Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267738AbUHRVAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267738AbUHRVAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUHRU7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:59:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267735AbUHRU7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:59:41 -0400
Date: Wed, 18 Aug 2004 13:56:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-Id: <20040818135638.4326ca02.davem@redhat.com>
In-Reply-To: <20040818205338.GF11200@holomorphy.com>
References: <20040818133348.7e319e0e.pj@sgi.com>
	<20040818205338.GF11200@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 13:53:38 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> Once it's decided how many it really takes, I'll fix up sparc32 as-needed.

(sorry for the emply reply previously)

It needs 6 unless we start passing in a 64-bit value to io_remap_page_range()
for the 'offset' parameter.

Physical I/O addresses are 36-bits or so on sparc32 systems, which is
why we need to pass in "offset" and "space".
