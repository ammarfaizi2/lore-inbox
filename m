Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUCLXfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUCLXfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:35:21 -0500
Received: from palrel10.hp.com ([156.153.255.245]:39621 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262541AbUCLXfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:35:00 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16466.18720.70066.525158@napali.hpl.hp.com>
Date: Fri, 12 Mar 2004 15:34:56 -0800
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com, grep@kroah.com,
       jgarzik@pobox.com, jun.nakajima@intel.com, tom.l.nguyen@intel.com,
       tony.luck@intel.com
Subject: Re: RE[PATCH]2.6.4-rc3 MSI Support for IA64
In-Reply-To: <Pine.LNX.4.58.0403121743310.29087@montezuma.fsmlabs.com>
References: <200403130008.i2D08SMQ011709@snoqualmie.dp.intel.com>
	<Pine.LNX.4.58.0403121743310.29087@montezuma.fsmlabs.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 12 Mar 2004 18:26:39 -0500 (EST), Zwane Mwaikambo <zwane@linuxpower.ca> said:

  Zwane> I wonder if we could consolidate these vector allocators as
  Zwane> assign_irq_vector(AUTO_ASSIGN) has the same semantics as
  Zwane> ia64_alloc_vector() and the one for i386 is also almost the
  Zwane> same as its MSI ilk.

Agreed.  I don't see any reason why ia64_alloc_vector() and
assign_irq_vector() couldn't or shouldn't be one and the same thing
(and assign_irq_vector() is a fine name).

Tom, if you want to send me a patch that converts the existing uses of
ia64_alloc_vector() to assign_irq_vector(), I'd be happy to apply
(assuming it's clean etc., as usual).

	--david
