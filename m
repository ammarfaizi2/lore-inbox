Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263172AbVCXTK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbVCXTK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbVCXTK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:10:27 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:32189
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263170AbVCXTKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:10:18 -0500
Date: Thu, 24 Mar 2005 11:03:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: davidm@hpl.hp.com, ak@muc.de, clameter@sgi.com,
       vda@port.imtp.ilyichevsk.odessa.ua, haveblue@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
Message-Id: <20050324110336.488241c4.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0503241038040.5663@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
	<200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
	<200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
	<20050318192808.GB38053@muc.de>
	<16963.2075.713737.485070@napali.hpl.hp.com>
	<Pine.LNX.4.58.0503241038040.5663@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 10:41:06 -0800 (PST)
Christoph Lameter <clameter@engr.sgi.com> wrote:

> So it would be useful to have
> 
> clear_page 	-> Temporal. Only zaps one page
> 
> 	and
> 
> clear_pages	-> Zaps arbitrary order of page non-temporal
> 
> 
> Rework the clear_pages patch to do just that? Maybe rename clear_pages
> clear_pages_nt?
> 
> prep_zero_page would use a temporal clear for an order 0 page but a
> nontemporal clear for higher order pages.

That sounds about right to me.

Hmmm, I'm inspired to experiment with this on sparc64 a bit.
:-)
