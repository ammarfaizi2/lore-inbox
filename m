Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbTBFLGK>; Thu, 6 Feb 2003 06:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbTBFLGK>; Thu, 6 Feb 2003 06:06:10 -0500
Received: from rth.ninka.net ([216.101.162.244]:24963 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S266535AbTBFLGK>;
	Thu, 6 Feb 2003 06:06:10 -0500
Subject: Re: skb_padto and small fragmented transmits
From: "David S. Miller" <davem@redhat.com>
To: Chris Leech <christopher.leech@intel.com>
Cc: netdev@oss.sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1044481190.9268.43.camel@localhost.localdomain>
References: <1044481190.9268.43.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Feb 2003 03:58:14 -0800
Message-Id: <1044532694.7679.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

skb_padto() only works on linear skb.

And if you look at all the drivers where it is used, they
do not enable things like scatter-gather.

