Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWAYHxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWAYHxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWAYHxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:53:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:25044 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750806AbWAYHxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:53:47 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) - safe_smp_processor_id
Date: Wed, 25 Jan 2006 08:53:47 +0100
User-Agent: KMail/1.8
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       ebiederm@xmission.com, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
References: <1138171868.2370.62.camel@localhost.localdomain> <20060124231052.7c9fcbec.akpm@osdl.org>
In-Reply-To: <20060124231052.7c9fcbec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601250853.48193.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 January 2006 08:10, Andrew Morton wrote:

> It assumes that all x86 SMP machines have APICs.  That's untrue of Voyager.
> I think we can probably live with this assumption - others would know
> better than I.

Early x86s didn't have APICs and they are still often disabled on not so 
old mobile CPUs.  I don't think it's a good assumption to make for i386.

-Andi
