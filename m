Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319040AbSIDDo4>; Tue, 3 Sep 2002 23:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSIDDo4>; Tue, 3 Sep 2002 23:44:56 -0400
Received: from holomorphy.com ([66.224.33.161]:2979 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319038AbSIDDoz>;
	Tue, 3 Sep 2002 23:44:55 -0400
Date: Tue, 3 Sep 2002 20:42:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davem@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix.
Message-ID: <20020904034212.GW888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, davem@vger.kernel.org,
	akpm@zip.com.au
References: <20020904023535.73D922C12D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020904023535.73D922C12D@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 12:35:41PM +1000, Rusty Russell wrote:
> Frankly, I'm amazed the kernel worked for long without this.
> Every linker script thinks the section is called .data.percpu.
> Without this patch, every CPU ends up sharing the same "per-cpu"
> variable.
> This might explain the wierd per-cpu problem reports from Andrew and
> Dave, and also that nagging feeling that I'm an idiot...

Hmm, 2.5.33 is doing some *really* weird crap. OTOH it doesn't appear
to be tripping the BUG() in softirq.c, and disks seem to be doing okay.
It survived 4 parallel mkfs's. I'll follow up with some kind of
bugreport on the PCI and/or starfire.c front in a separate post.


Cheers,
Bill
