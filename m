Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUBRU0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUBRU0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:26:08 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:16825 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268054AbUBRU0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:26:05 -0500
Date: Wed, 18 Feb 2004 20:23:25 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: Re: [PATCH] Enable Intel AGP on x86-64
Message-ID: <20040218202325.GZ6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ak@suse.de
References: <200402182006.i1IK6bL7022634@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402182006.i1IK6bL7022634@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 07:44:38PM +0000, Linux Kernel wrote:
 > ChangeSet 1.1564, 2004/02/18 11:44:38-08:00, ak@suse.de
 > 
 > 	[PATCH] Enable Intel AGP on x86-64
 > 	
 > 	Enable the Intel AGP driver for x86-64 too.

Please don't do this. At least copy intel-agp.c to
something new and throw out all the dozens of chipsets
that will never appear on ia32e.

Splitting agpgart up to seperate drivers allowed us
to stop adding cruft upon cruft with each generation
of chipsets.  I don't want to have to spend half of
2.7 decrufting agpgart again.

		Dave

