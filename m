Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbULCWSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbULCWSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbULCWSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:18:36 -0500
Received: from hera.kernel.org ([63.209.29.2]:7109 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262410AbULCWSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:18:23 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] Cyrix MII cpuid returns stale %ecx
Date: Fri, 3 Dec 2004 22:18:12 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <coqon4$p9e$1@terminus.zytor.com>
References: <Pine.LNX.4.61.0411302125350.1243@montezuma.fsmlabs.com> <20041203090843.GA25528@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1102112292 25903 127.0.0.1 (3 Dec 2004 22:18:12 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 3 Dec 2004 22:18:12 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041203090843.GA25528@wotan.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
>
> On Tue, Nov 30, 2004 at 10:07:55PM -0700, Zwane Mwaikambo wrote:
> > This patch is for the following bug, thanks to Ondrej Zary for 
> > reporting, testing and submitting a patch.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=3767
> > 
> > It appears that the Cyrix MII won't touch %ecx at all resulting in stale 
> > data being returned as extended attributes, so clear ecx before issuing 
> > the cpuid. I have also made the capability print code display all the 
> > capability words for easier debugging in future.
> 
> Can you please change cpuid() on x86-64 too?
> 
> I think it would be also better to not printk the capabilities
> at all or only with a special kernel option. Normally they are
> not needed, but they clutter up the boot  log.
> 

Since this is a bug fix for Cyrix MII, which isn't x86-64, it seems
pointless to do it for x86-64.

	-hpa
