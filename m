Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTKDWKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTKDWKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:10:54 -0500
Received: from rth.ninka.net ([216.101.162.244]:34689 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261152AbTKDWKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:10:52 -0500
Date: Tue, 4 Nov 2003 15:10:42 -0800
From: "David S. Miller" <davem@redhat.com>
To: "P. Christeas" <p_christ@hol.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lsmod ipv6 on -test9 shows many refs, lockd
Message-Id: <20031104151042.7b3f55cb.davem@redhat.com>
In-Reply-To: <200311041814.24731.p_christ@hol.gr>
References: <200311041814.24731.p_christ@hol.gr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 18:14:24 +0200
"P. Christeas" <p_christ@hol.gr> wrote:

> Question: is it normal for ipv6 module to have many refs while there is few 
> ipv6 connections ?
> My system is up for 3 days now. I have been using ACPI sleep and _ifconfig to 
> alter the ip address_. 
> lsmod gives:
> 	ipv6                  235904  34
> and lsof -i6 only shows two ports listening on ipv6.
> Even when I close all tcp (including v4) sockets, ipv6 still has around 10 
> refs in lsmod.

This is normal, ipv6 is not safe to unload as a module and therefore
the module reference count is always positive to prevent rmmod ipv6
from succeeding.

