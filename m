Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUHRU5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUHRU5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUHRU5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:57:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22700 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267690AbUHRU5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:57:10 -0400
Date: Wed, 18 Aug 2004 13:54:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-Id: <20040818135401.670f11bd.davem@redhat.com>
In-Reply-To: <20040818133348.7e319e0e.pj@sgi.com>
References: <20040818133348.7e319e0e.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 13:33:48 -0700
Paul Jackson <pj@sgi.com> wrote:

> Does anyone know the story behind this odd inconsistency?

Each platform needs different args, unfortunately.

Sparc needs the extra arg because the device space is described
with a base 32-bit address, then an upper 32-bit base to form
the full 64-bit address.  This upper 32-bit part is called the
"io_space" and thus is what gets passed into that 6-th argument.
