Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTKCWDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 17:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTKCWDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 17:03:01 -0500
Received: from palrel13.hp.com ([156.153.255.238]:20138 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263423AbTKCWDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 17:03:00 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16294.53393.763572.291298@napali.hpl.hp.com>
Date: Mon, 3 Nov 2003 14:02:57 -0800
To: Jes Sorensen <jes@wildopensource.com>
Cc: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>, linux-kernel@vger.kernel.org
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
In-Reply-To: <yq0sml5a63s.fsf@wildopensource.com>
References: <20031102181224.GD2149@ma.emulex.com>
	<yq0wuahan3t.fsf@trained-monkey.org>
	<20031103125259.GC16690@ma.emulex.com>
	<yq0sml5a63s.fsf@wildopensource.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 03 Nov 2003 09:17:59 -0500, Jes Sorensen <jes@wildopensource.com> said:

>>>>> "Jamie" == Jamie Wellnitz <Jamie.Wellnitz@emulex.com> writes:
  Jamie> On Mon, Nov 03, 2003 at 03:10:46AM -0500, Jes Sorensen wrote:
  >>> virt_to_page() can handle any page in the standard kernel region

  Jamie> What is the "standard kernel region"?  ZONE_NORMAL?

  Jes> Hmmm, my brain has gotten ia64ified ;-) It's basically the normal
  Jes> mappings of the kernel, ie. the kernel text/data/bss segments as well
  Jes> as anything you do not get back as a dynamic mapping such as
  Jes> ioremap/vmalloc/kmap.

I don't think it's safe to use virt_to_page() on static kernel
addresses (text, data, and bss).  For example, ia64 linux nowadays
uses a virtual mapping for the static kernel memory, so it's not part
of the identity-mapped segment.

	--david
