Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTLDMgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 07:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTLDMgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 07:36:08 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.194]:46065 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id S261758AbTLDMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 07:36:06 -0500
X-Biglobe-Sender: <slee@muf.biglobe.ne.jp>
Date: Thu, 04 Dec 2003 21:36:09 +0900
From: Stephen Lee <mukansai@emailplus.org>
To: "Feldman, Scott" <scott.feldman@intel.com>
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Cc: "Harald Welte" <laforge@netfilter.org>,
       <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD1F@orsmsx402.jf.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD1F@orsmsx402.jf.intel.com>
Message-Id: <20031204213030.2B75.MUKANSAI@emailplus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Feldman, Scott" <scott.feldman@intel.com> wrote:
> 
> Try turning off TSO by disabling this code or by using "ethtool -K tso
> off" (need version 1.8).

Yes, turning off TSO with ethtool fixed it (tested on 2.6.0-test11).  At
least we have a workaround now.

Thanks Scott, Harald and Dave.

Is it not supported by the hardware?  Seems TSO could improve
performance a bit since the 1000/MT Desktop is starved for PCI bandwidth
at 32-bit/33MHz.

Thanks,
Stephen

