Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVCKWp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVCKWp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVCKWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:44:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:13771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261756AbVCKWnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:43:01 -0500
Date: Fri, 11 Mar 2005 14:44:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <20050311222614.GH4185@redhat.com>
Message-ID: <Pine.LNX.4.58.0503111443480.3642@ppc970.osdl.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp>
 <20050311222614.GH4185@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Mar 2005, Dave Jones wrote:
> 
> I'm fascinated that not a single person picked up on this problem
> whilst the agp code sat in -mm. Even if DRI isn't enabled,
> every box out there with AGP that uses the generic routines
> (which is a majority), should have barfed loudly when it hit
> this check during boot.  Does no-one read dmesg output any more ?

I don't think it actuially causes a barf, because the counts start at 1,
and they go down to zero due to the double-free, but they don't become
negative until you do that whole detection loop _twice_. I think-

		Linus
