Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWHFQNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWHFQNY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWHFQNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 12:13:24 -0400
Received: from s-utl01-sjpop.stsn.net ([72.254.0.201]:31556 "HELO
	s-utl01-sjpop.stsn.net") by vger.kernel.org with SMTP
	id S932606AbWHFQNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 12:13:23 -0400
Subject: Re: writing portable code based on BITS_PER_LONG?
From: Arjan van de Ven <arjan@infradead.org>
To: "Om N." <xhandle@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6de39a910608052316x37ae7268j5ea18b6ea26219c5@mail.gmail.com>
References: <6de39a910608052316x37ae7268j5ea18b6ea26219c5@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 06 Aug 2006 18:12:55 +0200
Message-Id: <1154880775.3054.118.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 23:16 -0700, Om N. wrote:
> Hi,
> I am trying to port a driver written for IA32. This is a pci driver
> and has a chipset doing PCI <-> local bus data transfer, where local
> bus is 16 bit. So a number of values are converted by right/left
> shifting by 16 bits.
> 
> Now that I am doing porting, I would like to make it fully portable
> across AMD64 and IA32. What is the best method for this? Should I do
> something like,
> 
> #if  BITS_PER_LONG = 64
> shiftwidth = 48
> #else if BITS_PER_LONG = 32
> shiftwidth = 16
> #endif
> 
> I don't like this. I would not do it if there is some elegant way.


if you have a fixed sized bus, how about using the linux fixed size data
types? 

Also, maybe it would be a good idea to post the url to your code so that
people on this list can do a quick 64-bit safeness audit of your
driver... free work/help and all that ;-)

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


