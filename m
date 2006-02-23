Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWBWMHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWBWMHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWBWMHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:07:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3273 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751058AbWBWMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:07:37 -0500
Subject: Re: Areca RAID driver remaining items?
From: Arjan van de Ven <arjan@infradead.org>
To: erich <erich@areca.com.tw>
Cc: "\"\"Christoph Hellwig\"\"" <hch@infradead.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       billion.wu@areca.com.tw, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       oliver@neukum.org
In-Reply-To: <005a01c6386f$84b30d50$b100a8c0@erich2003>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com>
	 <20060220182045.GA1634@infradead.org>
	 <001401c63779$12e49aa0$b100a8c0@erich2003>
	 <20060222145733.GC16269@infradead.org>
	 <00dc01c63842$381f9a30$b100a8c0@erich2003>
	 <1140683157.2972.6.camel@laptopd505.fenrus.org>
	 <001901c6385e$9aee7d40$b100a8c0@erich2003>
	 <1140688569.4672.24.camel@laptopd505.fenrus.org>
	 <005a01c6386f$84b30d50$b100a8c0@erich2003>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 13:07:32 +0100
Message-Id: <1140696452.4672.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 19:51 +0800, erich wrote:
> If Linux can not assurent the contingous memory space allocating of 
> "dma_alloc_coherent" .

coherent memory is guaranteed to be in the "lower" 32 bit of memory!
So that is good news, I think you are just fine.

[Exception is that you can say that you are ok with a bigger mask for
this type of memory, but just don't do that if you're not]


> When arcmsr get a physical ccb address from areca's firmware.
> Does linux has any functions for converting of  "bus to virtual" ?

not without using pools. You would have to search the list of memory you
gave it to find that out.

(USB has a similar problem, afaik they solved it with pools)


