Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTKFTmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTKFTmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:42:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5801 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263698AbTKFTmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:42:32 -0500
Date: Thu, 6 Nov 2003 11:37:16 -0800
From: "David S. Miller" <davem@redhat.com>
To: azarah@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
Message-Id: <20031106113716.7382e5d2.davem@redhat.com>
In-Reply-To: <1068144179.12287.283.camel@nosferatu.lan>
References: <1068140199.12287.246.camel@nosferatu.lan>
	<20031106093746.5cc8066e.davem@redhat.com>
	<1068143563.12287.264.camel@nosferatu.lan>
	<1068144179.12287.283.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Nov 2003 20:42:59 +0200
Martin Schlemmer <azarah@gentoo.org> wrote:

> Ok, so maybe above is not a case to work on, but if I write an
> app that use only 32bit data types, and it links to a library that
> also handles 64bit, it does not matter, as I do not call the functions
> that handle 64bit data types, no ?

Let's say that you end up using some inline function
that takes u32 arguments, and internally it uses
u64 types to speed up the calculation or make it more
accurate or something like that.
