Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUKDOV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUKDOV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUKDOTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:19:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261179AbUKDOMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:12:52 -0500
Date: Thu, 4 Nov 2004 09:12:33 -0500
From: Dave Jones <davej@redhat.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: boot option for CONFIG_EDD_SKIP_MBR?
Message-ID: <20041104141233.GA32342@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <418A303E.1050709@gmx.net> <20041104134534.GA5360@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104134534.GA5360@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 07:45:34AM -0600, Matt Domsch wrote:
 > On Thu, Nov 04, 2004 at 02:35:58PM +0100, Carl-Daniel Hailfinger wrote:
 > > [please CC: me on replies]
 > > having had problems (inifinte hang on boot) with some Fujitsu
 > > Siemens Scenic computers when EDD was enabled, I asked myself
 > > if it would be possible to add a boot option edd=nombr and
 > > possibly also another boot option edd=off to the EDD code in
 > > the kernel. These would correspond to CONFIG_EDD_SKIP_MBR
 > > and CONFIG_EDD, respectively.
 > >
 > > Yes, option parsing before entering protected mode is ugly,
 > > but the vga setup code does it, too.
 > > 
 > > What do you think?
 > 
 > I'd love it.  I hadn't done it as I thought it would be ugly, and so
 > far I could blame buggy BIOSes for the delay.  If you want to work up
 > a patch, I'll gladly review and apply something that does such.

But would this actually be useful for the cases where EDD has been
broken so far ? AFAIR, the bootparam parsing happens /after/
we do the 16-bit EDD asm foo.

		Dave

