Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVCHEnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVCHEnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVCHEm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:42:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:1448 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261446AbVCHEmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:42:43 -0500
Subject: pci_fixup_video() bogosity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 15:38:29 +1100
Message-Id: <1110256709.13607.248.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While working on writing a VGA access arbiter for kernel & userland,
I wondered how to properly get my "initial" state at boot. For that,
I looked at how the new PCI ROM stuff does to find out who owns the
memory shadow at c0000, and found it quite bogus.

>From what I see, the code is only based on looking at what bridges
have VGA forwarding enabled. It doesn't test the actual IO and Memory
enable bits of the VGA cards themselves.

What if you have 2 cards under the same bridge ?

Ben.


