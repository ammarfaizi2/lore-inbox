Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269743AbUINUDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269743AbUINUDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbUINUBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:01:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32446 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269749AbUINUAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:00:41 -0400
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)
	Denial of Service Attack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Paul Jakma <paul@clubi.ie>, Ville Hallivuori <vph@iki.fi>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914194141.GF2780@alpha.home.local>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf>
	 <1095008692.11736.11.camel@localhost.localdomain>
	 <20040912192331.GB8436@hout.vanvergehaald.nl>
	 <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
	 <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
	 <20040913201113.GA5453@vph.iki.fi>
	 <Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
	 <1095174633.16990.19.camel@localhost.localdomain>
	 <20040914194141.GF2780@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095188200.17043.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 19:56:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 20:41, Willy Tarreau wrote:
> Just wondering, I have not checked. Isn't the "must fragment" message
> supposed to embed part of the packet it couldn't send in return ?

You need to guess no more than for an RST attack, and furthermore in
some cases (buggy stacks) IPsec doesn't save you because the error is
from an untrusted midpoint. The proper response to such messages is to
turn off DF usage but not all stacks get it right

