Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTLDUKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTLDUKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:10:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49793 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263102AbTLDUKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:10:18 -0500
Message-ID: <3FCF9497.3030708@pobox.com>
Date: Thu, 04 Dec 2003 15:09:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Lee <mukansai@emailplus.org>
CC: "Feldman, Scott" <scott.feldman@intel.com>,
       Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Extremely slow network with e1000 & ip_conntrack
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD21@orsmsx402.jf.intel.com> <20031205045020.4C0E.MUKANSAI@emailplus.org>
In-Reply-To: <20031205045020.4C0E.MUKANSAI@emailplus.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lee wrote:
> I have a 32-bit PCI card with bcm5705 on it, does that support TSO? 
> I'll give it a try today.


I'm pretty sure tg3 does not enable TSO support by default.

Regardless, the problem is identified -- when TSO+conntrack is present,
we "TSO" net traffic then "un-TSO" it.

It's simply better to not use TSO at all, for this case.

	Jeff



