Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTFDSIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTFDSIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:08:31 -0400
Received: from CPE-24-163-209-144.mn.rr.com ([24.163.209.144]:43905 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S263752AbTFDSIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:08:30 -0400
Subject: Re: iptables & 2.5 problem
From: Shawn <core@enodev.com>
To: Harald Welte <laforge@netfilter.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030604180726.GG29818@sunbeam.de.gnumonks.org>
References: <1054747598.12295.5.camel@localhost>
	 <20030604180726.GG29818@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1054750920.6370.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 04 Jun 2003 13:22:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This would be great, except for iptables does not build against
linux-2.5.70-mm3 due to lack of IPT_PHYSDEV_OP_MATCH_IN and
IPT_PHYSDEV_OP_MATCH_OUT.

For that matter, there is no IPT_PHYSDEV_OP_MATCH* at all in the kernel
source.

On Wed, 2003-06-04 at 13:07, Harald Welte wrote:
> On Wed, Jun 04, 2003 at 12:26:38PM -0500, Shawn wrote:
> > The problem illustrated here:
> > # iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> > iptables: Invalid argument
> > 
> > This box is a gentoo running iptables-1.2.8-r1 and linux-2.5.70-mm3.
> > Config attached.
> 
> This sounds like your iptables userspace command was compiled for a
> kernel with different headers.  Please rebuild iptables and make sure it
> actually uses the headers of your 2.5.70-mm3 kernel.
