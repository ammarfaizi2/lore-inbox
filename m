Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWAXBUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWAXBUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWAXBUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:20:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:62891 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030279AbWAXBUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:20:43 -0500
From: Andi Kleen <ak@suse.de>
To: Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Tue, 24 Jan 2006 02:11:58 +0100
User-Agent: KMail/1.8.2
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601240139.46751.ak@suse.de> <08A96D993E5CB2984F6F448A@[10.1.1.4]>
In-Reply-To: <08A96D993E5CB2984F6F448A@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240211.59171.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 01:51, Dave McCracken wrote:
>  Most of the large OLTP applications use fixed address
> mapping for their large shared regions.

Really? That sounds like a quite bad idea because it can easily break
if something changes in the way virtual memory is laid out (which
has happened - e.g. movement to 4level page tables on x86-64 and now
randomized mmaps) 

I don't think we should encourage such unportable behaviour.

-Andi
