Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTJDFv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 01:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTJDFv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 01:51:29 -0400
Received: from rth.ninka.net ([216.101.162.244]:5011 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261856AbTJDFv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 01:51:27 -0400
Date: Fri, 3 Oct 2003 22:51:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vishwas Raman <vishwas@eternal-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing tcp socket information from within a module
Message-Id: <20031003225124.17a440c2.davem@redhat.com>
In-Reply-To: <3F7E0DFF.2030404@eternal-systems.com>
References: <3F7E0DFF.2030404@eternal-systems.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Oct 2003 17:02:07 -0700
Vishwas Raman <vishwas@eternal-systems.com> wrote:

> Is there some way of accessing the information of all open tcp sockets 
> in the system, other than having to turn one of IPV6 or KHTTPD on?

You don't even need to write your kernel module, there is already
a special netlink socket provided to userspace exactly for this
purpose, to get info on all TCP sockets efficiently.

See net/ipv4/tcp_diag.c
