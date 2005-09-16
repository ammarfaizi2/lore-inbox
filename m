Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbVIPIdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbVIPIdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVIPIdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:33:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52700 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161129AbVIPIdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:33:05 -0400
Date: Fri, 16 Sep 2005 04:32:51 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-bugs@digital-trauma.de, len.brown@intel.com, linux-acpi@intel.com,
       mm-commits@vger.kernel.org
Subject: Re: + acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549.patch added to -mm tree
Message-ID: <20050916083251.GB26128@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-bugs@digital-trauma.de,
	len.brown@intel.com, linux-acpi@intel.com,
	mm-commits@vger.kernel.org
References: <200509160403.j8G43ECq009024@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509160403.j8G43ECq009024@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 09:02:43PM -0700, Andrew Morton wrote:

 > From: Thomas Rosner <kernel-bugs@digital-trauma.de>
 > 
 > This adds all known BIOS versions of IBM R40e Laptops to the C2/C3
 > processor state blacklist and thus prevents them from crashing.  Fixes Bug
 > #3549.
 > 
 > Implementation is probably overly verbose, but DMI_MATCH seems to give us
 > no choice.

I sent a similar patch to the list earlier this week, which also fixed
up the braindamaged indentation that Lindent recently did to the file.
I missed some of the ones you had though, and it seems, you also
missed one.

+   { set_max_cstate, "IBM ThinkPad R40e", {
+    DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+    DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") },
+    (void*)1},



		Dave

