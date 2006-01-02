Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWABIhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWABIhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 03:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWABIhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 03:37:34 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:59589 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932334AbWABIhd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 03:37:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cuoy2RjPosZTe1Ss7ayRabwd6iTpNdTwbx9Yi7l6ifkmZMSOzCDqCeOdfuaax2EogatBYz12AR1M5bfbzlyvONd39Mz5W6rhY6nKKc0/X8Hco0v7F53KHSv+vzUtqYebrxaSFnvQA+lxTxKGSBSvcEYV4TrQibRtE+e3rBdGrEs=
Message-ID: <84144f020601020037n7af7ac54l74cdbe602372c7f@mail.gmail.com>
Date: Mon, 2 Jan 2006 10:37:31 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andreas Kleen <ak@suse.de>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Cc: Denis Vlasenko <vda@ilport.com.ua>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	 <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua>
	 <200512281054.26703.vda@ilport.com.ua>
	 <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/05, Andreas Kleen <ak@suse.de> wrote:
> I remember the original slab paper from Bonwick actually mentioned that
> power of two slabs are the worst choice for a malloc - but for some reason Linux
> chose them anyways.

Power of two sizes are bad because memory accesses tend to concentrate
on the same cache lines but slab coloring should take care of that. So
I don't think there's a problem with using power of twos for kmalloc()
caches.

                                   Pekka
