Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbTBFTMB>; Thu, 6 Feb 2003 14:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTBFTMA>; Thu, 6 Feb 2003 14:12:00 -0500
Received: from fmr02.intel.com ([192.55.52.25]:44763 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267630AbTBFTL7>; Thu, 6 Feb 2003 14:11:59 -0500
Subject: Re: skb_padto and small fragmented transmits
From: Chris Leech <christopher.leech@intel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F20BA2AAE3@orsmsx118.jf.intel.com>
References: <BD9B60A108C4D511AAA10002A50708F20BA2AAE3@orsmsx118.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044559328.4618.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 06 Feb 2003 11:22:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 10:44, David S. Miller wrote:
>    From: Chris Leech <christopher.leech@intel.com>
>    Date: 06 Feb 2003 11:22:51 -0800
>    
>    I fail to see how the statement "skb->len + skb->data_len" has any
>    usable meaning, or how it can be anything other than a bug.
> 
> This equation is the standard way to find the full length
> on any skb.  For linear skbs, data_len is always zero.
> 
> I asked Alan to use this formula so that greps on the source
> tree would always show data_len being taken into account, and
> thus usage would be consistent.

OK, now I'm really getting confused.  Every other example I can find in
the networking code, and every scatter-gather capable driver, uses
skb->len as the full length and skb->len - skb->data_len as the length
of the first or linear portion.


