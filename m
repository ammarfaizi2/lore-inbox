Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVCKW1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVCKW1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVCKW1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:27:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261782AbVCKW0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:26:20 -0500
Date: Fri, 11 Mar 2005 17:26:14 -0500
From: Dave Jones <davej@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050311222614.GH4185@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vf7xg72s.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 07:18:19AM +0900, OGAWA Hirofumi wrote:
 > Linus Torvalds <torvalds@osdl.org> writes:
 > 
 > > Hmm.. We seem to not have any tests for the counts becoming negative, and
 > > this would seem to be an easy mistake to make considering that both I and 
 > > Dave did it.
 > 
 > I stole this from -mm.

I'm fascinated that not a single person picked up on this problem
whilst the agp code sat in -mm. Even if DRI isn't enabled,
every box out there with AGP that uses the generic routines
(which is a majority), should have barfed loudly when it hit
this check during boot.  Does no-one read dmesg output any more ?

Maybe OSDL can add an automated test to send diffs of dmesg
between kernels like they do the automated warning announcements 8-)

		Dave

