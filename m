Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUHXSwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUHXSwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUHXSwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:52:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268190AbUHXSwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:52:04 -0400
Date: Tue, 24 Aug 2004 11:50:46 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: bunk@fs.tum.de, cherry@osdl.org, linux-kernel@vger.kernel.org,
       jmorris@redhat.com
Subject: Re: 2.6.9-rc1: selinux/hooks.c: functions returning unassigned
 variables
Message-Id: <20040824115046.660ef050.davem@redhat.com>
In-Reply-To: <1093362104.1800.156.camel@moss-spartans.epoch.ncsc.mil>
References: <200408241519.i7OFJS6S027910@cherrypit.pdx.osdl.net>
	<20040824153342.GG7019@fs.tum.de>
	<1093362104.1800.156.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 11:41:45 -0400
Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> On Tue, 2004-08-24 at 11:33, Adrian Bunk wrote:
> > On Tue, Aug 24, 2004 at 08:19:28AM -0700, John Cherry wrote:
> > >...
> > > security/selinux/hooks.c:2825: warning: `ret' might be used uninitialized in this function
> > > security/selinux/hooks.c:2886: warning: `ret' might be used uninitialized in this function
> > 
> > 
> > This was
> >   [NET]: Add skb_header_pointer, and use it where possible.
> > 
> > 
> > @Dave:
> > In both functions ret is returned, but line that assigned a value to ret 
> > was removed.

Good catch.  Patch applied, thanks Stephen.
