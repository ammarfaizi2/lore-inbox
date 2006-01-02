Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWABIqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWABIqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 03:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWABIqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 03:46:51 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:64425 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932330AbWABIqv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 03:46:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c8YQnRT4lwzSEHSM0mLjvjIX64VmQir3yjCQztQOSo1Xm3Ig+ishz28i2mBbw+6V2FORcanSlYwPbPkPf/uTMnLrvHeAJy3+7z82T/NQXbj3b7BN1RFisKb/POqHSkO+cMhNfFUshnNhB5G9rqCX9ctA89Zoy4w9kreWjbTCy9I=
Message-ID: <84144f020601020046t3176cde2k7d9ec900cafd6d2f@mail.gmail.com>
Date: Mon, 2 Jan 2006 10:46:49 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Eric Dumazet <dada1@cosmosbay.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Andreas Kleen <ak@suse.de>, Matt Mackall <mpm@selenic.com>
In-Reply-To: <1135915609.6039.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	 <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua>
	 <200512281054.26703.vda@ilport.com.ua>
	 <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
	 <20051228210124.GB1639@waste.org> <20051229012616.GA3286@redhat.com>
	 <1135915609.6039.39.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/30/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> Attached is a variant that was refreshed against 2.6.15-rc7 and fixes
> the logical bug that your compile error fix made ;)
>
> It should be cachep->objsize not csizep->cs_size.

Isn't there any other way to do this patch other than making kzalloc()
and kstrdup() inline? I would like to see something like this in the
mainline but making them inline is not acceptable because they
increase kernel text a lot.

                       Pekka
