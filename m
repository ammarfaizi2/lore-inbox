Return-Path: <linux-kernel-owner+w=401wt.eu-S1754925AbXABUMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbXABUMJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbXABUMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:12:08 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:46701 "EHLO rs27.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925AbXABUMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:12:07 -0500
Message-ID: <459ABC7C.2030104@firmworks.com>
Date: Tue, 02 Jan 2007 10:11:40 -1000
From: Mitch Bradley <wmb@firmworks.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       David Miller <davem@davemloft.net>, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <459714A6.4000406@firmworks.com>	 <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>	 <20061231.124531.125895122.davem@davemloft.net>	 <1167709406.6165.6.camel@localhost.localdomain>	 <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org> <1167768494.6165.63.camel@localhost.localdomain>
In-Reply-To: <1167768494.6165.63.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> We could of course have the interface work either on a copy of the tree
> or on a real OF (though that means changing things like get_property on
> powerpc and fixing the gazillions of users) but I tend to think that
> working on a copy always is more efficient.
>
>   
The patch that I posted creates a copy in the virtual filesystem 
domain.  So the efficiency issue is moot.

The filesystem domain copy is smaller than the in-memory tree, as it 
omits a lot of unnecessary fields.

