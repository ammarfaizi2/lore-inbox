Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315433AbSEBV32>; Thu, 2 May 2002 17:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315434AbSEBV31>; Thu, 2 May 2002 17:29:27 -0400
Received: from holomorphy.com ([66.224.33.161]:2520 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315433AbSEBV30>;
	Thu, 2 May 2002 17:29:26 -0400
Date: Thu, 2 May 2002 14:28:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502212810.GN32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <148490000.1020378039@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
>> I believe 64-bit PCI is pretty much taken to be a requirement; if it
>> weren't the 4GB limit would once again apply and we'd be in much
>> trouble, or we'd have to implement a different method of accommodating
>> limited device addressing capabilities and would be in trouble again.

On Thu, May 02, 2002 at 03:20:39PM -0700, Martin J. Bligh wrote:
> IIRC, there are some funny games you can play with 32bit PCI DMA.
> You're not necessarily restricted to the bottom 4Gb of phys addr space, 
> you're restricted to a 4Gb window, which you can shift by programming 
> a register on the card. Fixing that register to point to a window for the 
> node in question allows you to allocate from a node's pg_data_t and 
> assure DMAable RAM is returned.
> M.


Woops, I forgot about the BAR, thanks. Heck, IIRC you were even the one
who told me about this trick.

Thanks,
Bill
