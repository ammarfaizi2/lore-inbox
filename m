Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbUK3Sv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbUK3Sv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUK3SuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:50:10 -0500
Received: from holomorphy.com ([207.189.100.168]:53918 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262244AbUK3StE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:49:04 -0500
Date: Tue, 30 Nov 2004 10:48:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041130184852.GI2714@holomorphy.com>
References: <20041130095045.090de5ea.akpm@osdl.org> <1101837994.2640.67.camel@laptop.fenrus.org> <20041130102105.21750596.akpm@osdl.org> <1101839110.2640.69.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101839110.2640.69.camel@laptop.fenrus.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 10:21 -0800, Andrew Morton wrote:
>> For pages which have a physical address <4G.  I assume this was motivated
>> by the lack of an IOMMU on ia32e?

On Tue, Nov 30, 2004 at 07:25:10PM +0100, Arjan van de Ven wrote:
> but there's the swiommu for those... so that can't be it
> realistically....
> Is there code using the zone GFP mask yet ??

ZONE_NORMAL and ZONE_DMA are both too overloaded to handle the 4GB
boundary. And it makes a lot of sense on more machine types than x86-64
(e.g. ia64, ia32 and others with 32-bit PCI but no zone representing it).


-- wli
