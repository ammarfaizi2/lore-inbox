Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269126AbUIBVKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269126AbUIBVKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbUIBVJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:09:57 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:13466
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268370AbUIBVJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:09:14 -0400
Date: Thu, 2 Sep 2004 14:07:59 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: benh@kernel.crashing.org, akpm@osdl.org, wli@holomorphy.com,
       davem@redhat.com, raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040902140759.5f1003d5.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
	<20040815185644.24ecb247.davem@redhat.com>
	<Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<1094012689.6538.330.camel@gaston>
	<Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
	<1094080164.4025.17.camel@gaston>
	<Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com>
	<20040901215741.3538bbf4.davem@davemloft.net>
	<Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
	<20040902131057.0341e337.davem@davemloft.net>
	<Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004 14:02:47 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> I have the similar issues with the page scalability patch. Should I not do
> the legacy thing for platforms that do not have atomic pte operations?
> '

I think your situation is different.  The set_pte() changes are modifying
the arguments of an existing interface.

Your changes are adding support for taking advantage of a facility
that may or may not exist on a platform.
