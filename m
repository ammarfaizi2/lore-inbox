Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUGFWo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUGFWo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUGFWo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:44:57 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:61412 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264582AbUGFWoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:44:54 -0400
Date: Wed, 7 Jul 2004 00:44:53 +0200
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, shemminger@osdl.org,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040706224453.GA6694@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>,
	Jamie Lokier <jamie@shareable.org>, shemminger@osdl.org,
	netdev@oss.sgi.com, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20040629222751.392f0a82.davem@redhat.com> <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net> <20040630153049.3ca25b76.davem@redhat.com> <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net> <20040706194034.GA11021@mail.shareable.org> <20040706131235.10b5afa8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706131235.10b5afa8.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 01:12:35PM -0700, David S. Miller wrote:

> It is this specific case:
> 
> 1) SYN packet contains window scale option of ZERO.

Not true - the outgoing SYN packet had window scale 7, when it was sent. The
SYN|ACK had window scale 0, when received by the initiating system.

Also - even if the remote were to assume a 47 byte window size, would it not
be able to send small packets? Or does the window size also include
packet haders?

Regards,

bert


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
