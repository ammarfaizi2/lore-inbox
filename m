Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTDPNq6 (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTDPNq6 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:46:58 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:31981 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264374AbTDPNq4 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 09:46:56 -0400
Date: Wed, 16 Apr 2003 14:58:19 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030416135819.GB18358@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net> <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk> <20030416131536.GF29143@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416131536.GF29143@iucha.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 08:15:36AM -0500, Florin Iucha wrote:

 > 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
 > 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL
 > [Radeon 8500 LE]
 > 
 > Maybe the AGP code is trying to push some bits in the wrong
 > port/address?

SiS driver internals haven't changed (at least not under my hands),
so it should be poking the same bits in the same registers as the
2.4 driver does. The only 'bits in wrong address' type bug outstanding
in agpgart is that the gatt_table address is potentially allocated as
a 64bit address and truncated to fit into 32bits, but that will only bite
you on a 64bit host that uses the generic gatt allocation routines.
(Namely x86-64).

		Dave

