Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbULGRpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbULGRpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbULGRpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:45:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:64951 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261863AbULGRpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:45:39 -0500
Date: Tue, 7 Dec 2004 09:45:35 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Phil Oester <kernel@linuxace.com>, "David S. Miller" <davem@davemloft.net>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] fix select() for SOCK_RAW sockets
Message-Id: <20041207094535.11080082@dxpl.pdx.osdl.net>
In-Reply-To: <20041207150834.GA75700@gaz.sfgoth.com>
References: <20041207003525.GA22933@linuxace.com>
	<20041207025218.GB61527@gaz.sfgoth.com>
	<20041207045302.GA23746@linuxace.com>
	<20041207054840.GD61527@gaz.sfgoth.com>
	<20041207150834.GA75700@gaz.sfgoth.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004 07:08:34 -0800
Mitchell Blank Jr <mitch@sfgoth.com> wrote:

> Phil: Here's a real patch for you to test.  I actually left inet_dgram_ops
> alone since it's an exported symbol (two of the users just want the .do_ioctl
> value which is the same between SOCK_DGRAM and SOCK_RAW; the other is ipv6
> where it's clearly dealing with a UDP socket -- therefore I think its safest
> to leave inet_dgram_ops to have the UDP behavior)
> 
> Davem: I only tested that this doesn't break UDP; if it works for Phil and
> Stephen can verify that it doesn't break his bad-checksum UDP tests then
> please push it for 2.6.10.
> 

Thanks, I'll retest UDP today, but it looks right.
