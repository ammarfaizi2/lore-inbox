Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269465AbTGJQMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269467AbTGJQMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:12:39 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:23170 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S269465AbTGJQMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:12:37 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: CaT <cat@zip.com.au>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       pekkas@netcore.fi
In-Reply-To: <20030710154302.GE1722@zip.com.au>
References: <20030710154302.GE1722@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057854432.3588.2.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jul 2003 19:27:13 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 18:43, CaT wrote:
> ip tunnel add sit1 mode sit remote 138.25.6.14
> ip link set sit1 up
> ip addr add 3ffe:8001:000c:ffff::37/127 dev sit1
>  ip route add ::/0 via 3ffe:8001:000c:ffff::36 
> RTNETLINK answers: Invalid argument

Try this:

ip route add ::/0 dev sit1

	MikaL

