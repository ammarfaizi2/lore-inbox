Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTLXVOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLXVOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:14:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:16822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263895AbTLXVOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:14:20 -0500
Date: Wed, 24 Dec 2003 13:12:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ben Srour <srour@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Safe ISA port probing?
Message-Id: <20031224131223.2c3f497c.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0312241431280.2726-100000@data.upl.cs.wisc.edu>
References: <20031224200433.GC6577@kroah.com>
	<Pine.LNX.4.44.0312241431280.2726-100000@data.upl.cs.wisc.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003 14:33:54 -0600 (CST) Ben Srour <srour@cs.wisc.edu> wrote:

| Hello,
| 
| What is the safest way to go about probing for non-pnp ISA devices on a
| system?

To be very safe, use a parameter and don't do probing, except to
verify that the device is where you have been told it is.

| Is the only solution to start at a base address and increment until you
| find something interesting? Won't this put devices along the way in an
| unsafe state?

It could.

| Any advice/suggestions would be appreciated,

There's not a method that's always safe AFAIK.

It's better to use reads instead of writes if possible.
It's better to begin at the least-used addresses of other
known devices as much as possible (but you know that).

--
~Randy
MOTD:  Always include version info.
