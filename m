Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265918AbSKBKSZ>; Sat, 2 Nov 2002 05:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265919AbSKBKSZ>; Sat, 2 Nov 2002 05:18:25 -0500
Received: from rth.ninka.net ([216.101.162.244]:47831 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265918AbSKBKSY>;
	Sat, 2 Nov 2002 05:18:24 -0500
Subject: Re: Patch?: linux-2.5.45/net/ipv4/ dst.pmtu compilation fixes
From: "David S. Miller" <davem@redhat.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: alan@redhat.com, slouken@cs.ucdavis.edu,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021101031638.A349@baldur.yggdrasil.com>
References: <20021101031638.A349@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 02:39:24 -0800
Message-Id: <1036233564.11040.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 03:16, Adam J. Richter wrote:
> 	I am not currently familiar with this code, so I could easily
> have misunderstood something in my patch.

The only mistakes is that you cannot assign to
dst->metrics[RTAX_PMTU-1], you must use
dst->ops->update_mtu() instead.

I've made this change and installed the fixes to my
tree.  Thanks.

