Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbUKJPfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUKJPfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUKJPfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 10:35:55 -0500
Received: from linux.us.dell.com ([143.166.224.162]:20342 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261886AbUKJPfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 10:35:48 -0500
Date: Wed, 10 Nov 2004 09:35:34 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Michael E Brown <mebrown@michaels-house.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Add boot sector checksums to EDD
Message-ID: <20041110153533.GA23981@lists.us.dell.com>
References: <4191A8D7.1030300@michaels-house.net> <4191ABE8.1060703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4191ABE8.1060703@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 06:49:28AM +0100, Carl-Daniel Hailfinger wrote:
> Michael E Brown schrieb:

(copying lkml again)

> >    I'm curious, do you have a tool that uses the boot sector checksum? I
> > can think of a couple of places it could be useful, but all of my
> > use-cases are adequately covered by simple signature.
> 
> The tool is SUSE hwinfo. Currently its author does the checksumming
> in the bootloader which kills some BIOSes (1st EDD request in the
> bootloader is ok, second request by kernel EDD startup code hangs
> the machine).

I'd be curious to understand this better.  i.e. failure mode, why it
fails, for what systems, etc.
 
> I have some drives with identical mbr_signature (drives were wiped
> with dd before I got them). Using a checksum gives me at least some
> chance to identify them better because one has a bootloader, the
> other hasn't, they have different partition tables etc.

What wrote the bootloader to the first disk?  Can *that* write a
unique signature into the disk?  Red Hat's build of parted includes a
patch I wrote (not yet included in parted upstream IIRC) which has
parted write a unique signature to each disk, so that's how we solve
it there...

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
