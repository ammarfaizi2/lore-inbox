Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVGFVPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVGFVPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVGFVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:12:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262563AbVGFVMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:12:06 -0400
Date: Wed, 6 Jul 2005 17:11:59 -0400
From: Dave Jones <davej@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedstep-centrino on dothan
Message-ID: <20050706211159.GF27630@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <20050706112202.33d63d4d@horst.morte.male> <42CC37FD.5040708@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CC37FD.5040708@tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 03:58:53PM -0400, Bill Davidsen wrote:
 > st3@riseup.net wrote:
 > >Currently, the speedstep-centrino support has built-in frequency/voltage
 > >pairs only for Banias CPUs. For Dothan CPUs, these tables are read from
 > >BIOS ACPI.
 > >
 > >But ACPI encoding may not be available or not reliable, so why shouldn't we
 > >provide built-in tables for Dothan CPUs, too? Intel has released this
 > >datasheet:
 > >
 > >http://www.intel.com/design/mobile/datashts/302189.htm
 > >
 > >with frequency/voltage pairs for every version of Dothan CPUs.
 > >
 > >Moreover, I checked on Pentium M 725 and Pentium M 715 that the lowest
 > >frequency at which the CPU can be set safely is not the 600MHz given in
 > >datasheets, but 400MHz instead, with VID#A, VID#B, VID#C and VID#D (see
 > >datasheet for more details) set to 0.908V.
 > >
 > >I can provide a patch, let me know.
 > 
 > Slower is better, and not depending on ACPI for anything which can be 
 > gotten elsewhere is a good thing. Sounds like a good idea to me.

This can't be done safely through any other means than ACPI right now.
It needs to know intimate things about which VID line is wired to what,
which is board specific.

		Dave

