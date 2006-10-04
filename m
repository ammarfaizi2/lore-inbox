Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWJDE30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWJDE30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWJDE30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:29:26 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:12168 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932376AbWJDE3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:29:25 -0400
Date: Wed, 4 Oct 2006 00:28:50 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061004042850.GA27149@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003201340.afa7bfce.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 08:13:40PM -0700, Andrew Morton wrote:
> On Tue, 3 Oct 2006 13:25:11 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > Increasingly the cobbled together boot protocol that
> > is bzImage does not have the flexibility to deal
> > with booting in new situations.
> > 
> > Now that we no longer support the bootsector loader
> > we have 512 bytes at the very start of a bzImage that
> > we can use for other things.
> > 
> > Placing an ELF header there allows us to retain
> > a single binary for all of x86 while at the same
> > time describing things that bzImage does not allow
> > us to describe.
> 
> Seems that the entire kernel effort is an ongoing plot to make my poor
> little Vaio stop working.  This patch turns it into a black-screened rock
> as soon as it does grub -> linux.  Stock-standard FC5 install, config at
> http://userweb.kernel.org/~akpm/config-sony.txt.

Hi Andrew,

Right now I don't have access to my test machine.  Tomorrow morning,
very first thing I am going to try it out with your config file.

This patch just adds and ELF header to bzImage which is not even used
by grub.

So without this patch you are able to boot the kernel on your laptop?

Thanks
Vivek
