Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275465AbTHJDys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 23:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275466AbTHJDys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 23:54:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22699 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275465AbTHJDyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 23:54:47 -0400
Date: Sat, 9 Aug 2003 20:49:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030809204927.46b84c83.davem@redhat.com>
In-Reply-To: <20030810031418.GW31810@waste.org>
References: <20030809074459.GQ31810@waste.org>
	<20030809143314.GT31810@waste.org>
	<1060481247.31499.62.camel@localhost>
	<20030810031418.GW31810@waste.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 22:14:18 -0500
Matt Mackall <mpm@selenic.com> wrote:

> On Sat, Aug 09, 2003 at 07:07:27PM -0700, Robert Love wrote:
> > On Sat, 2003-08-09 at 07:33, Matt Mackall wrote:
> > What if you kept crypto API optional, made random.c a config option, and
> > make that depend on the crypto API.
 ...
> Eek, let's not go there.

I definitely agree, removing the integrity of random.c is not
an option.  Even things inside the kernel itself rely upon
get_random_bytes() for anti-DoS measures.
