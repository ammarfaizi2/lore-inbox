Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUGFUUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUGFUUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGFUU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:20:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58799 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263457AbUGFUUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:20:19 -0400
Date: Tue, 6 Jul 2004 13:17:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706131731.540dd5fd.davem@redhat.com>
In-Reply-To: <20040706185856.GN18841@lug-owl.de>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	<20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	<20040706185856.GN18841@lug-owl.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 20:58:56 +0200
Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:

> On Tue, 2004-07-06 11:47:41 -0700, Stephen Hemminger <shemminger@osdl.org>
> wrote in message <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>:
> 
> > I propose that the following that will avoid sending window scaling that
> > is big enough to break in these cases unless the tcp_rmem has been increased.
> > It will keep default configuration from blowing in a corrupt world.
> 
> I'm not sure if this is the right way to react. I'd think it's okay to
> give the user the possibility to scale the window so that it works with
> his b0rk3d firewall, but default behavior should be to do whatever the
> protocol dictates/allows.

I totally agree, and that's why the sysctl is there for people to
tweak as they desire.

Jan, any particular reason you removed so much stuff (in particular
netdev@oss.sgi.com) from the CC: list in your posting here?
