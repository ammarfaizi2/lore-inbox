Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUIJObT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUIJObT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUIJObT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:31:19 -0400
Received: from jade.spiritone.com ([216.99.193.136]:23441 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267427AbUIJObR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:31:17 -0400
Date: Fri, 10 Sep 2004 07:30:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com
cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <593560000.1094826651@[10.10.2.4]>
In-Reply-To: <1094807650.17041.3.camel@localhost.localdomain>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <1094807650.17041.3.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Friday, September 10, 2004 10:14:11 +0100):

> On Gwe, 2004-09-10 at 07:40, Arjan van de Ven wrote:
>> Well I always assumed the future plan was to remove 8k stacks entirely;
>> 4k+irqstacks and 8k basically have near comparable stack space, with
>> this patch you create an option that has more but that is/should be
>> deprecated. I'm not convinced that's a good idea.
> 
> Its probably appropriate to drop gcc 2.x support at that point too since
> it's the major cause of remaining problems

What problems does it cause? 2.95.4 still seems to work fine for me.

I agree about killing anything but 4K stacks though - having the single
page is very compelling - not only can we allocate it easier, but we can
also use cache-hot pages from the hot list.

M.

