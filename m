Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWJEPtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWJEPtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWJEPtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:49:41 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:41351 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751570AbWJEPtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:49:40 -0400
Date: Thu, 5 Oct 2006 11:49:38 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Joerg Roedel <joro-lkml@zlug.org>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] net/ipv6: seperate sit driver to extra module
In-Reply-To: <20061005154152.GA2102@zlug.org>
Message-ID: <Pine.LNX.4.64.0610051148230.23631@d.namei>
References: <20061005154152.GA2102@zlug.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Joerg Roedel wrote:

> Is there a reason why the tunnel driver for IPv6-in-IPv4 is currently
> compiled into the ipv6 module? This driver is only needed in gateways
> between different IPv6 networks. On all other hosts with ipv6 enabled it
> is not required. To have this driver in a seperate module will save
> memory on those machines.
> I appended a small and trival patch to 2.6.18 which does exactly this.

Looks ok to me, although given that users used to get this by default when 
selecting IPv6, perhaps the default in Kconfig should be y.



- James
-- 
James Morris
<jmorris@namei.org>
