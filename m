Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWFKQC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWFKQC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 12:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWFKQC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 12:02:27 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:32424 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751636AbWFKQC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 12:02:26 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Frost <artusemrys@sbcglobal.net>, Alex Tomas <alex@clusterfs.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4489C34B.1080806@garzik.org>
References: <4488E1A4.20305@garzik.org>
	 <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org>
	 <448992EB.5070405@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org>
	 <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org>
	 <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net>
	 <20060609181426.GC5964@schatzie.adilger.int>  <4489C34B.1080806@garzik.org>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 18:02:18 +0200
Message-Id: <1150041738.3131.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 14:51 -0400, Jeff Garzik wrote:
> PRECISELY.  So you should stop modifying a filesystem whose design is 
> admittedly _not_ modern!
> 
> ext3 is already essentially xiafs-on-life-support, when you consider 
> today's large storage systems and today's filesystem technology.  Just 
> look at the ugly hacks needed to support expanding an ext3 filesystem 
> online.


actually I think I disagree with you. One thing I've noticed over the
years is that ext2 layout has one thing going for it: it is simple and
robust. Maybe "ext2 layout" is the wrong word, "block bitmap and
direct/indirect block based" may be better. It seems that once you go
into tree space (and I would call htree a borderline thing there) you
get both really complex code and fragile behavior all over (mostly in
terms of "when something goes wrong")

