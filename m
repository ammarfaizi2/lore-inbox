Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbULGR2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbULGR2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULGR2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:28:20 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:36992
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261860AbULGR2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:28:13 -0500
Date: Tue, 7 Dec 2004 09:28:12 -0800
From: Phil Oester <kernel@linuxace.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: "David S. Miller" <davem@davemloft.net>, shemminger@osdl.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] fix select() for SOCK_RAW sockets
Message-ID: <20041207172812.GA25810@linuxace.com>
References: <20041207003525.GA22933@linuxace.com> <20041207025218.GB61527@gaz.sfgoth.com> <20041207045302.GA23746@linuxace.com> <20041207054840.GD61527@gaz.sfgoth.com> <20041207150834.GA75700@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207150834.GA75700@gaz.sfgoth.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 07:08:34AM -0800, Mitchell Blank Jr wrote:
> Phil: Here's a real patch for you to test.  I actually left inet_dgram_ops
> alone since it's an exported symbol (two of the users just want the .do_ioctl
> value which is the same between SOCK_DGRAM and SOCK_RAW; the other is ipv6
> where it's clearly dealing with a UDP socket -- therefore I think its safest
> to leave inet_dgram_ops to have the UDP behavior)
> 
> Davem: I only tested that this doesn't break UDP; if it works for Phil and
> Stephen can verify that it doesn't break his bad-checksum UDP tests then
> please push it for 2.6.10.

Yup, that does indeed fix it for me, thanks.

Phil


