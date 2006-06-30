Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWF3A3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWF3A3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWF3A3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:29:11 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:51115 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S964818AbWF3A3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:29:08 -0400
Date: Thu, 29 Jun 2006 17:28:51 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: David Miller <davem@davemloft.net>
Cc: bos@pathscale.com, akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath
 on PowerPC 970 systems
In-Reply-To: <fa./e2EfI5SsRLt5d/gFrBSOnDZpZ0@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0606291725020.16720@osa.unixfolk.com>
References: <fa.KkJLjFz0MBUMS9nMlAyiBMrqx1g@ifi.uio.no>
 <fa./e2EfI5SsRLt5d/gFrBSOnDZpZ0@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, David Miller wrote:

| From: Bryan O'Sullivan <bos@pathscale.com>
| Date: Thu, 29 Jun 2006 14:41:29 -0700
| 
| >  ipath_core-$(CONFIG_X86_64) += ipath_wc_x86_64.o
| > +ipath_core-$(CONFIG_PPC64) += ipath_wc_ppc64.o
| 
| Again, don't put these kinds of cpu specific functions
| into the infiniband driver.  They are potentially globally
| useful, not something only Infiniband might want to do.

The new code simply sets a flag as to whether instruction level
write barriers need to be used or not, it doesn't contain actual
code.

The older file (already accepted) does have some setup code, as well as
code setting flags, due to the fact that Bryan mentioned in his reply,
that this stuff simply doesn't yet exist in a generic form.   It's not
clear to me that it can ever be made to exist in a generic form that will
actually work on multiple architectures (or that there are enough users
to be worth trying).   We can make the attempt, but so far it's pretty
non-generic, in it's very nature.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
