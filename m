Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWDSKpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWDSKpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 06:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDSKpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 06:45:53 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:62779 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750727AbWDSKpw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 06:45:52 -0400
From: Christian Borntraeger <borntrae@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Date: Wed, 19 Apr 2006 12:45:48 +0200
User-Agent: KMail/1.9.1
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, shemminger@osdl.org,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       fpavlic@de.ibm.com, davem@sunset.davemloft.net
References: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com> <20060408100213.GA9412@osiris.boeblingen.de.ibm.com> <20060408031235.5d1989df.akpm@osdl.org>
In-Reply-To: <20060408031235.5d1989df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604191245.48458.borntrae@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As spinlock debugging still does not work with the qeth driver I want to pick 
up the discussion.

On Saturday 08 April 2006 12:12, Andrew Morton wrote:
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
[...]
> >  -vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
> >  +vmlinux-main := $(core-y) $(libs-y) $(net-y) $(drivers-y)
>
> <wonders what this will break>

What about putting this patch into mm and find out?
>
> I have a bad feeling that one day we're going to come unstuck with this
> practice.  Is there anything which dictates that the linker has to lay
> sections out in .o-file-order?
>
> Perhaps net initcalls should be using something higher priority than
> device_initcall().

I agree that the initcall order offers a lot of room for improvement (like 
dependencies). Is anybody aware of any work into this direction?

-- 
Mit freundlichen Grüßen / Best Regards

Christian Borntraeger
Linux Software Engineer zSeries Linux & Virtualization



