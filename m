Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUEYVwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUEYVwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUEYVuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:50:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265111AbUEYVtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:49:43 -0400
Date: Tue, 25 May 2004 14:47:59 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: marcelo.tosatti@cyclades.com, doug@easyco.com,
       linux-kernel@vger.kernel.org, cramerj@intel.com, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, jgarzik@pobox.com
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed
 (gfp=0x20/1) - Not out of memory
Message-Id: <20040525144759.0e51cfd9.davem@redhat.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF618C@orsmsx402.amr.corp.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF618C@orsmsx402.amr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 14:20:23 -0700
"Feldman, Scott" <scott.feldman@intel.com> wrote:

> Marcelo Tosatti wrote:
> 
> > It seems we are calling alloc_skb(GFP_KERNEL) from inside an 
> > interrupt handler. Oops. 
> 
> We're calling dev_alloc_skb() from hard interrupt context, but it uses
> GFP_ATOMIC, not GFP_KERNEL, so this is OK, right?  I don't see the
> problem with e1000.

Neither do I, where is the detailed backtrace of this GFP_KERNEL
allocation supposedly from interrupt context?
