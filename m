Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUDVSii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUDVSii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUDVSii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:38:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264625AbUDVSig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:38:36 -0400
Date: Thu, 22 Apr 2004 11:36:45 -0700
From: "David S. Miller" <davem@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: jmorris@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Large inlines in include/linux/skbuff.h
Message-Id: <20040422113645.19208a70.davem@redhat.com>
In-Reply-To: <200404221756.46240.vda@port.imtp.ilyichevsk.odessa.ua>
References: <Xine.LNX.4.44.0404212046490.20483-100000@thoron.boston.redhat.com>
	<200404221756.46240.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004 17:56:46 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> On Thursday 22 April 2004 03:47, James Morris wrote:
> > On Wed, 21 Apr 2004, Denis Vlasenko wrote:
> > > What shall be done with this? I'll make patch to move locking functions
> > > into net/core/skbuff.c unless there is some reason not to do it.
> >
> > How will these changes impact performance?  I asked this last time you
> > posted about inlines and didn't see any response.
> 
> Hard to say. We will lose ~2% to extra call/return instructions
> but will gain 40kb of icache space.

He's asking you to test and quantify the performance changes that
occur as a result of this patch, not to figure it out via calculations
in your head :-)
