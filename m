Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267733AbUGWOD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267733AbUGWOD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 10:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267735AbUGWOD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 10:03:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:6828 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267733AbUGWOD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 10:03:28 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Date: Fri, 23 Jul 2004 09:01:33 -0500
User-Agent: KMail/1.6.2
Cc: Walter Hofmann <lkml-040723143345-5954@secretlab.mine.nu>,
       Andrew Morton <akpm@osdl.org>
References: <2kvT4-5AY-1@gated-at.bofh.it> <2kECW-3a0-7@gated-at.bofh.it> <E1BnzGM-0005zX-00@gimli.local>
In-Reply-To: <E1BnzGM-0005zX-00@gimli.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407230901.33814.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 July 2004 7:34 am, Walter Hofmann wrote:
> You wrote on linux.kernel:
> > Your points can be simplified to "I don't use cryptoloop, but someone
> > else might" and "we shouldn't do this in a stable kernel".
> >
> > Well, I want to hear from "someone else".  If removing cryptoloop will
> > irritate five people, well, sorry.  If it's 5,000 people, well maybe not.
>
> I use cryptoloop and I would be really annoyed if it disappeared in
> the stable kernel series. Besides, I read in another mail in this thread
> that dm-crypt will not work with file-based storage (I'm using
> cryptoloop on a file), and that it is new and potentially buggy.

Just to clarify this one point...
Device-Mapper (and thus dm-crypt) can only create mappings on block-devices. 
However, in your situation, you could just take a two-step approach of 
creating a loop device on the encrypted file (using losetup), and then using 
dm-crypt on top of this loop device.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
