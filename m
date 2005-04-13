Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVDMKlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVDMKlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVDMKlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:41:03 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:53454 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261296AbVDMKk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:40:58 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [2.6 patch] sound/oss/rme96xx.c: fix two check after use
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Reply-To: 7eggert@gmx.de
Date: Wed, 13 Apr 2005 12:40:38 +0200
References: <3SGgN-41r-1@gated-at.bofh.it> <3SGA8-4n3-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DLfIV-0000pl-Fa@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:
> On Wed, Apr 13, 2005 at 04:17:42AM +0200, Adrian Bunk wrote:

>> This patch fixes two check after use found by the Coverity checker.
> 
> Bullshit.  ->private_data is set by rme96xx_open() to guaranteed non-NULL
> and never changed elsewhere.  Same comment about reading the fscking
> source, BUG_ON(), etc.

If there are checks, they should be there for a purpose, and any sane
reader will asume these checks to be nescensary. If they are dead code, you
can say that, but please don't flame Adrian for fixing obviously buggy code
in a way that is sane and at least more correct than the original without
using several days of his lifetime to analyze the whole driver. Instead, you
could provide the correct fix.
-- 
Funny quotes:
33. If lawyers are disbarred and clergymen defrocked, doesn't it follow that
    electricians can be delighted, musicians denoted, cowboys deranged, models
    deposed, tree surgeons debarked, and dry cleaners depressed?
