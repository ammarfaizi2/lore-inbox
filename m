Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbTILBwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbTILBwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:52:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28650 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261650AbTILBwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:52:01 -0400
Date: Thu, 11 Sep 2003 18:41:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: dada1@cosmosbay.com, jun.nakajima@intel.com, ak@muc.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Network buffer hang was Re: [PATCH] 2.6 workaround for
 Athlon/Opteron prefetch errata
Message-Id: <20030911184103.2646b189.davem@redhat.com>
In-Reply-To: <3F612570.1010303@candelatech.com>
References: <uqD5.3BI.3@gated-at.bofh.it>
	<m3iso0arlx.fsf@averell.firstfloor.org>
	<0a5801c37821$54eb8180$890010ac@edumazet>
	<20030911051121.GA7751@colin2.muc.de>
	<0a7701c37829$c4bdef40$890010ac@edumazet>
	<20030911120956.GB7751@colin2.muc.de>
	<0b2901c37867$1db399a0$890010ac@edumazet>
	<3F612570.1010303@candelatech.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 18:46:24 -0700
Ben Greear <greearb@candelatech.com> wrote:

> I was using kernel 2.4.21 or so, and had tcp buffers turned up
> quite high.

You seal your own fate by setting this too high.  It's meant
to keep TCP from commiting too much system memory to itself.
