Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTKFRnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTKFRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:43:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51879 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263778AbTKFRnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:43:01 -0500
Date: Thu, 6 Nov 2003 09:37:46 -0800
From: "David S. Miller" <davem@redhat.com>
To: azarah@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
Message-Id: <20031106093746.5cc8066e.davem@redhat.com>
In-Reply-To: <1068140199.12287.246.camel@nosferatu.lan>
References: <1068140199.12287.246.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Nov 2003 19:36:39 +0200
Martin Schlemmer <azarah@gentoo.org> wrote:

> On Tue, 2003-05-06 at 04:19, David S. Miller wrote:
> > On Tue, 2003-05-06 at 02:16, Thomas Horsten wrote: 
> > > The following patch fixes the problem:
> >
> > Making the u64 swabbing functions unavailable is not an 
> > acceptable solution. 
> >
> 
> Sorry to dig this up again, but wont __STRICT_ANSI__ assume
> that the program will not use u64 functions (as the program/compiler
> is supposed to adhere to ansi standards)?

It may make indirect use of inline functions in the kernel headers
in question, which themselves need to use the u64 type.
