Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280017AbRKISHs>; Fri, 9 Nov 2001 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280018AbRKISHi>; Fri, 9 Nov 2001 13:07:38 -0500
Received: from [212.18.232.186] ([212.18.232.186]:14855 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S280017AbRKISH0>; Fri, 9 Nov 2001 13:07:26 -0500
Date: Fri, 9 Nov 2001 18:07:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Clark <matt@eee.nott.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dev driver / pci throughput
Message-ID: <20011109180718.A14307@flint.arm.linux.org.uk>
In-Reply-To: <Pine.OSF.4.31.0111091022010.26869-100000@perry>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.OSF.4.31.0111091022010.26869-100000@perry>; from matt@eee.nottingham.ac.uk on Fri, Nov 09, 2001 at 10:48:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 10:48:58AM +0000, Matthew Clark wrote:
> 
> MEM_reg=ioremap(pci_resource_start(dev,B_SM_MEM)&PCI_BASE_ADDRESS_MEM_MASK,REG_SIZE);
> 

Not directly related to your query, but a general observation:  You don't
need to mask with PCI_BASE_ADDRESS_MEM_MASK - this is already handled by
the generic PCI layer when it reads the PCI BARs.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

