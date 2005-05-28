Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVE1BuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVE1BuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 21:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVE1BuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 21:50:22 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:7604 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261965AbVE1BuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 21:50:13 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Subject: Re: How to find if BIOS has already enabled the device
Date: Fri, 27 May 2005 21:50:14 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505272150.15109.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 21:34, Aleksey Gorelov wrote:
> See if 'usb-handoff' as a kernel parameter makes it any better.
>
> Aleks.

Nope - Doesn't help as expected. The offending code is in hcd-pci.c - which 
seems to be executed unconditionally. usb_hcd_pci_probe() calls 
pci_enable_device() which hangs if there was already a device present, 
attached to the controller. 

Parag
