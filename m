Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUFQONl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUFQONl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUFQONl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:13:41 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:1493 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266509AbUFQONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:13:40 -0400
Date: Thu, 17 Jun 2004 15:13:10 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: HayArms <voloterreno@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7] AGP KT600 identified as CLE266
Message-ID: <20040617141310.GB19280@redhat.com>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	HayArms <voloterreno@tin.it>, linux-kernel@vger.kernel.org
References: <40D1A282.7010006@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D1A282.7010006@tin.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 03:54:10PM +0200, HayArms wrote:
 > Hi all,
 > 
 > I've compiled vanilla kernel 2.6.7 just today, and I've noticed that my 
 > KT600 AGP chipset is identified ad CLE266 :
 > 
 > Linux agpgart interface v0.100 (c) Dave Jones
 > agpgart: Detected VIA CLE266 chipset
 > agpgart: Maximum main memory to use for agp memory: 438M
 > agpgart: AGP aperture is 256M @ 0xc0000000

Can you apply this..
http://www.codemonkey.org.uk/projects/bitkeeper/agpgart/agpgart-2004-06-17.diff

on top, and see if it fixes itself ? There was a missing table
entry, which could have caused all the subsequent entries
to be off by one. (And CLE266 is the entry before the KT600)

		Dave

