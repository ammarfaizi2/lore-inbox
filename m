Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVEBRgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVEBRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVEBRf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:35:58 -0400
Received: from bay102-f13.bay102.hotmail.com ([64.4.61.23]:12919 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261473AbVEBRey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:34:54 -0400
Message-ID: <BAY102-F13EED31CA6775F78BC88E4AE270@phx.gbl>
X-Originating-IP: [64.4.61.200]
X-Originating-Email: [jocosby@hotmail.com]
From: "Joseph Cosby" <jocosby@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PCI: Multiple domains not supported
Date: Mon, 02 May 2005 11:34:54 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 02 May 2005 17:34:55.0122 (UTC) FILETIME=[40F36720:01C54F3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm getting, "PCI: Multiple domains not supported," when I boot with a 
2.6.11 kernel. Then the machine hangs after trying to bind a PCI device with 
the message, "Invalid ACPI-PCI context for parent device PCI1."
  The first message comes from pci_acpi_scan_root, when passed a non-zero 
domain. This is called from acpi_pci_root_add, which passes the domain 
obtained from _SEG. The machine that I have is AMD with 3 root PCI busses, 
so it has _SEG=0, 1 and 2 respectively.
  If I pass pci=noacpi to the kernel then the machine can boot, and finds 
the devices correctly.
  My questions are whether this is a known issue, and also if anybody knows 
any workarounds besides the extra boot time parameters to the kernel.
  Any help is appreciated.

Thank you,
Joseph

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

