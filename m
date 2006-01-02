Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWABTeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWABTeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWABTeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:34:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbWABTeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:34:01 -0500
Date: Mon, 2 Jan 2006 11:30:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: khc@pm.waw.pl, mingo@elte.hu, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-Id: <20060102113013.4227b83e.akpm@osdl.org>
In-Reply-To: <20060102191720.GI22293@devserv.devel.redhat.com>
References: <20051230074916.GC25637@elte.hu>
	<20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu>
	<20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<1136198902.2936.20.camel@laptopd505.fenrus.org>
	<20060102134345.GD17398@stusta.de>
	<20060102140511.GA2968@elte.hu>
	<m3ek3qcvwt.fsf@defiant.localdomain>
	<20060102110341.03636720.akpm@osdl.org>
	<20060102191720.GI22293@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> wrote:
>
> inline keyword has always been a hint.
>

Kernel does

# define inline           inline          __attribute__((always_inline))

for gcc-3 and gcc-4.
