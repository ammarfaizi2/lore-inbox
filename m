Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUALQfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUALQfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:35:34 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:20428 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266198AbUALQf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:35:29 -0500
Date: Mon, 12 Jan 2004 16:33:57 +0000
From: Dave Jones <davej@redhat.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, thomas@winischhofer.net,
       linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-ID: <20040112163357.GA20815@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	thomas@winischhofer.net, linux-kernel@vger.kernel.org,
	jsimmons@infradead.org
References: <20040109014003.3d925e54.akpm@osdl.org> <200401112353.43282.gene.heskett@verizon.net> <20040111214259.568cff35.akpm@osdl.org> <200401120121.12122.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401120121.12122.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 01:21:12AM -0500, Gene Heskett wrote:

 > DRM? lemme see if thats even turned on.  Nope "# CONFIG_DRM is not set"
 > Doing a make xconfig, I see that if I turn it on, there is not a 
 > driver for my gforce2/nvidia, so I naturally turned it back off.
 > 
 > I do have VIA and agpgart enabled just above it

With CONFIG_DRM off, the AGP options may as well be turned off too,
as they do nothing[1] on a system without 3d acceleration.

		Dave

[1] Well, unless you have an Intel i8xx chipset where you need it for
    the horrid framebuffer needs memory through GART hack.
	And in your case, you don't have one of these.
