Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVD0PCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVD0PCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVD0PCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:02:08 -0400
Received: from mail.enyo.de ([212.9.189.167]:9613 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261703AbVD0PCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:02:04 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <20050426004111.GI21897@waste.org>
	<200504260713.26020.mason@suse.com>
	<aec7e5c305042608095731d571@mail.gmail.com>
	<200504261138.46339.mason@suse.com>
	<aec7e5c305042609231a5d3f0@mail.gmail.com>
	<20050426135606.7b21a2e2.akpm@osdl.org>
	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
	<20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com>
Date: Wed, 27 Apr 2005 17:01:47 +0200
In-Reply-To: <426ED20B.9070706@zytor.com> (H. Peter Anvin's message of "Tue,
	26 Apr 2005 16:43:07 -0700")
Message-ID: <871x8wb6w4.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Peter Anvin:

> While you're doing this anyway, you might want to make sure you enable 
> -O +dir_index and run fsck -D.

Directory hashing has a negative impact on some applications (notably
tar and unpatched mutt on large Maildir folders).  For git, it's a win
because hashing destroys locality anyway.
