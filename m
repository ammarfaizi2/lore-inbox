Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTBGM0J>; Fri, 7 Feb 2003 07:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTBGM0J>; Fri, 7 Feb 2003 07:26:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58786
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263313AbTBGM0I>; Fri, 7 Feb 2003 07:26:08 -0500
Subject: Re: skb_padto and small fragmented transmits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: christopher.leech@intel.com, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030206.144306.14966745.davem@redhat.com>
References: <BD9B60A108C4D511AAA10002A50708F20BA2AAE3@orsmsx118.jf.intel.com>
	 <1044559328.4618.54.camel@localhost.localdomain>
	 <20030206.144306.14966745.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044624820.14026.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Feb 2003 13:33:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 22:43, David S. Miller wrote:
>    From: Chris Leech <christopher.leech@intel.com>
>    Date: 06 Feb 2003 11:22:08 -0800
>    
>    OK, now I'm really getting confused.  Every other example I can find in
>    the networking code, and every scatter-gather capable driver, uses
>    skb->len as the full length and skb->len - skb->data_len as the length
>    of the first or linear portion.
>    
> Indeed, Alan you need to fix the skb_padto stuff to use
> skb->len, ignore the skb->data_len as skb->len is the
> full length.

Dave just fix it next time you touch the code and push it to Marcelo. It
doesnt affect the 2.2 backport so that will be ok


