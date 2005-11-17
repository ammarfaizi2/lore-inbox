Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVKRAAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVKRAAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVKRAAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:00:00 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49809
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965168AbVKRAAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:00:00 -0500
Date: Thu, 17 Nov 2005 15:58:56 -0800 (PST)
Message-Id: <20051117.155856.44665420.davem@davemloft.net>
To: davej@redhat.com
Cc: linux@dominikbrodowski.net, hugh@veritas.com, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051117205156.GH5772@redhat.com>
References: <20051117194102.GE5772@redhat.com>
	<20051117204617.GA10925@isilmar.linta.de>
	<20051117205156.GH5772@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Thu, 17 Nov 2005 15:51:56 -0500

> On Thu, Nov 17, 2005 at 09:46:17PM +0100, Dominik Brodowski wrote:
> 
>  > > Actually Dave Miller did the detective work on that one, I just
>  > > rebuilt some packages, and spread the good word :)
>  > 
>  > My Samsung X05 requires vbetool to resume from suspend-to-ram properly. Up
>  > to 2.6.14, vbetool-0.3 worked fine; the PageReserved patch broke this (as
>  > reported). Also the new package by Dave {Miller,Jones} didn't help and does
>  > not help, even with these new 11 patches.
>  
> Davem's initial analysis was on ddcprobe, it's possible that whilst the
> code is the same in both projects, that vbetool's needs are different
> enough to require a different patch.

I don't think so, but lrmi.c instances are doing exactly the
same stuff so the same fix ought to work in both spots.

It could be some other 2.6.15 change that's mucked up suspend-to-ram
resume for this person.
