Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbTATLtP>; Mon, 20 Jan 2003 06:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTATLtP>; Mon, 20 Jan 2003 06:49:15 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:19204 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265681AbTATLtO>; Mon, 20 Jan 2003 06:49:14 -0500
Date: Mon, 20 Jan 2003 14:57:54 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, akpm@zip.com.au
Subject: Re: pci_child_fixup()
Message-ID: <20030120145754.A912@jurassic.park.msu.ru>
References: <20030120035217.GE770@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030120035217.GE770@holomorphy.com>; from wli@holomorphy.com on Sun, Jan 19, 2003 at 07:52:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 07:52:17PM -0800, William Lee Irwin III wrote:
>  		child = pci_add_new_bus(bus, dev, 0);
> -		child->primary = buses & 0xFF;
> -		child->secondary = (buses >> 8) & 0xFF;
> -		child->subordinate = (buses >> 16) & 0xFF;
> -		child->number = child->secondary;
> +		pci_child_fixup(bus, child, buses);

The "bus" argument seems to be redundant. Why not use "child->parent"
just filled in by pci_add_new_bus() instead?

Ivan.
