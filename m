Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031263AbWI0X5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031263AbWI0X5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031265AbWI0X5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:57:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031263AbWI0X5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:57:15 -0400
Date: Wed, 27 Sep 2006 16:57:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Filip <bugtraq@smoula.net>
Cc: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: forcedeth - WOL [SOLVED]
Message-Id: <20060927165704.613bf0aa.akpm@osdl.org>
In-Reply-To: <1159389486.8902.4.camel@archon.smoula-in.net>
References: <1159379441.9024.7.camel@archon.smoula-in.net>
	<20060927183857.GA2963@atjola.homenet>
	<1159389486.8902.4.camel@archon.smoula-in.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 22:38:06 +0200
Martin Filip <bugtraq@smoula.net> wrote:

> Hi,
> 
> Bj__rn Steinbrink p____e v St 27. 09. 2006 v 20:38 +0200:
> 
> > Did you check that WOL was enabled? I need to re-activate it after each
> > boot (I guess that's normal, not sure though).
> > The output of "ethtool eth0" should show:
> > 
> >         Supports Wake-on: g
> >         Wake-on: g
> > 
> Yes, of course :)
> 
> > Also, I remember a bugzilla entry in which it was said that the MAC was
> > somehow reversed by the driver. I that is still the case (I can't find
> > the bugzilla entry right now), you might just reverse the MAC address in
> > your WOL packet to workaround the bug.
> 
> Hey! this is really crazy :) but it works! To bo honest - I really do
> not know what crazy bug could cause problems like this. I thought it's
> NIC thing to manage all the work about WOL. I thought OS only sets NIC
> into "WOL mode".
> 
> But seeing this - one packet for windows and one magic packet for linux
> driver - I really do not get it.
> 

Are you saying that byte-reversing the MAC address make WOL work correctly?

What tool do you use to send the packet, and how is it being invoked?

Do we know if this reversal *always* happens with this driver, or only
sometimes?

Thanks.
