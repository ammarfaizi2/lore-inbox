Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUCJDjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 22:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUCJDjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 22:39:54 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:11790 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261464AbUCJDjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 22:39:53 -0500
Date: Wed, 10 Mar 2004 04:38:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sridhar Samudrala <sri@us.ibm.com>
cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Cleaner way to conditionally disallow a CONFIG option as static
In-Reply-To: <Pine.LNX.4.58.0403081659170.1656@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0403100437040.27654@serv>
References: <Pine.LNX.4.58.0403081659170.1656@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Mar 2004, Sridhar Samudrala wrote:

> In 2.6, net/sctp/Kconfig
>
> config IPV6_SCTP__
> 	tristate
> 	default y if IPV6=n
> 	default IPV6 if IPV6
>
> config IP_SCTP
> 	tristate "The SCTP Protocol (EXPERIMENTAL)"
> 	depends on IPV6_SCTP__

This can be written as:

config IP_SCTP
	tristate "The SCTP Protocol (EXPERIMENTAL)"
	depends on IPV6 || IPV6=n

bye, Roman
