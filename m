Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTEGO2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTEGO2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:28:37 -0400
Received: from holomorphy.com ([66.224.33.161]:40847 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263228AbTEGO2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:28:35 -0400
Date: Wed, 7 May 2003 07:41:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030507144100.GD8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, helgehaf@aitel.hist.no,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com
References: <3EB8DBA0.7020305@aitel.hist.no> <1052304024.9817.3.camel@rth.ninka.net> <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507.025626.10317747.davem@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Hafting <helgehaf@aitel.hist.no>
Date: Wed, 07 May 2003 12:49:48 +0200
>    No, I compile everything into a monolithic kernel.
>    I don't even enable module support.

On Wed, May 07, 2003 at 02:56:26AM -0700, David S. Miller wrote:
> Andrew, color me stumped.  mm2/linux.patch doesn't have anything
> really interesting in the networking.  Maybe it's something in
> the SLAB and/or pgd/pmg re-slabification changes?

The i810 bits would be a failure case of the original slabification.
At first glance the re-slabification doesn't seem to conflict with the
unmapping-based slab poisoning.

In another thread, you mentioned that a certain netfilter cset had
issues; I think it might be good to add that as a second possible cause.

I'm trying to track down testers with i810's to reproduce the issue,
but the usual suspects and helpers aren't awake yet (most/all of my
target systems are headless, though I regularly abuse my laptop, which
appears to S3/Savage -based and so isn't useful for this).

-- wli
