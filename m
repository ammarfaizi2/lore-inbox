Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSHLD0o>; Sun, 11 Aug 2002 23:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318657AbSHLD0o>; Sun, 11 Aug 2002 23:26:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14855 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318650AbSHLD0n>;
	Sun, 11 Aug 2002 23:26:43 -0400
Message-ID: <3D572E2F.D7DE8DF9@zip.com.au>
Date: Sun, 11 Aug 2002 20:40:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812025431.GA4429@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> FYI, just got this while un-tarring a kernel tree with 2.5.31+everything.gz:
> (no nvidia ;)
> 

That'll be this one:

	        BUG_ON(page->pte.chain != NULL);

we've had a few reports of this dribbling in since rmap went in.  But
nothing repeatable enough for it to be hunted down.

But we do have a repeatable inconsistency happening with ntpd and
memory pressure.  That may be related, but in that case it's probably
related to mlock().

So.  An open bug, alas.
