Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVCBIDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVCBIDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 03:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVCBIDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 03:03:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262218AbVCBIDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 03:03:07 -0500
Date: Wed, 2 Mar 2005 03:02:55 -0500
From: Dave Jones <davej@redhat.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050302080255.GA28512@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain> <20050302075037.GH20190@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302075037.GH20190@apps.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 08:50:38AM +0100, Andries Brouwer wrote:
 > On Tue, Mar 01, 2005 at 11:52:44PM +0000, Alan Cox wrote:
 > > On Llu, 2005-02-28 at 19:20, Andries Brouwer wrote:
 > > > One such case is the mtrr code, where struct mtrr_ops has an
 > > > init field pointing at __init functions. Unless I overlook
 > > > something, this case may be easy to settle, since the .init
 > > > field is never used.
 > > 
 > > The failure to invoke the ->init operator appears to be the bug.
 > > The centaur code definitely wants the mcr init function to be called.
 > 
 > Yes, I expected that to be the answer. Therefore #if 0 instead of deleting.
 > But if calling ->init() is needed, and it has not been done the past
 > three years, the question arises whether there are any users.

The Winchips never really sold that well, and stopped being produced
when IDT sold off Centaur.  It was a niche processor in 1997. In 2005,
I'll be surprised if there are that many of them still working.
Mine lost its magic smoke for no reason around ~2002.

If there are any of them still being used out there, I'd be even
more surprised if they're running 2.6.  Then again, there are
probably loonies out there running it on 386/486's. 8-)

		Dave

