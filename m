Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVKUV7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVKUV7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVKUV7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:59:18 -0500
Received: from [205.233.219.253] ([205.233.219.253]:24736 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751108AbVKUV7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:59:17 -0500
Date: Mon, 21 Nov 2005 16:52:26 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Ben Collins <bcollins@debian.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051121215226.GN20781@conscoop.ottawa.on.ca>
References: <20051120232009.GH16060@stusta.de> <20051120234055.GF28918@redhat.com> <20051120235242.GR16060@stusta.de> <43821C47.6010702@s5r6.in-berlin.de> <20051121185609.GB14962@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121185609.GB14962@swissdisk.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 10:56:09AM -0800, Ben Collins wrote:
> > 
> > This looks OK to me. But there seems to be another bug. I think the line
> > 
> > 	kfree(cache);
> > 
> > after the if and else blocks has to be replaced by
> > 
> > 	CSR1212_FREE(cache);
> 
> Yes, please. We are trying to keep the csr1212.[ch] files compatible for
> use in userspace and kernel.

raw1394.c does not have to be kept compatible.  Stefan's suggestion
doesn't hurt though.  Anyone have a patch?

Cheers,
Jody


> 
> -- 
> Ubuntu     - http://www.ubuntu.com/
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> SwissDisk  - http://www.swissdisk.com/
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
