Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293465AbSCEQqK>; Tue, 5 Mar 2002 11:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293459AbSCEQqA>; Tue, 5 Mar 2002 11:46:00 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:52463 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293465AbSCEQor>;
	Tue, 5 Mar 2002 11:44:47 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15492.62946.952197.632931@napali.hpl.hp.com>
Date: Tue, 5 Mar 2002 08:44:18 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: sp@scali.com, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
In-Reply-To: <20020305.074722.25911127.davem@redhat.com>
In-Reply-To: <200203051112.DAA03159@adam.yggdrasil.com>
	<20020305.031636.63129004.davem@redhat.com>
	<3C84E785.1D102FF9@scali.com>
	<20020305.074722.25911127.davem@redhat.com>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 05 Mar 2002 07:47:22 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM>    I know pci_map_single (and _sg) will use bounce buffers on
  DaveM> platforms without an IOMMU,

  DaveM> 64-bit platforms without IOMMU use HIGHMEM.

Not true for ia64 linux.

  DaveM>    It could for example be solved with a GFP_32BIT flag or
  DaveM> something (on IA64 I know GFP_DMA is used in
  DaveM> pci_alloc_consistent() to get memory below 4GB but that can't
  DaveM> be used on all platforms).

  DaveM> IA64 was broken, it now uses HIGHMEM.

No it doesn't.  Perhaps you meant to say that the Red Hat version of
the ia64 linux kernel uses highmem?

	--david
