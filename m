Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUCRSaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbUCRSaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:30:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262851AbUCRSaI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:30:08 -0500
Date: Thu, 18 Mar 2004 10:30:04 -0800
From: "David S. Miller" <davem@redhat.com>
To: mru@kth.se (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] alignment problem in net/core/flow.c:flow_key_compare
Message-Id: <20040318103004.2cf4de34.davem@redhat.com>
In-Reply-To: <yw1x4qsmv1kq.fsf@kth.se>
References: <yw1x8yhyv33l.fsf@kth.se>
	<yw1x4qsmv1kq.fsf@kth.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004 12:25:57 +0100
mru@kth.se (Måns Rullgård) wrote:

> mru@kth.se (Måns Rullgård) writes:
> 
> > The solutions I see are either to force the alignment of struct flowi
> > to 64 bits, or to use 32-bit access in flow_key_compare.
> 
> I forgot to mention that this is kernel 2.6.4.

Yes, just add an alignment attribute of some kind to the struct
is probably the best idea.
