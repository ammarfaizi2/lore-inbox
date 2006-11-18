Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756058AbWKRGiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058AbWKRGiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbWKRGiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:38:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:43953 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1756058AbWKRGiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:38:22 -0500
Date: Sat, 18 Nov 2006 07:38:02 +0100
From: Andi Kleen <ak@suse.de>
To: LKML <linux-kernel@vger.kernel.org>, olecom@flower.upol.cz,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       hpa@zytor.com, Reloc Kernel List <fastboot@lists.osdl.org>,
       pavel@suse.cz, magnus.damm@gmail.com, ak@suse.de
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Message-ID: <20061118063802.GE30547@bingen.suse.de>
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com> <slrnelt6h7.dd3.olecom@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnelt6h7.dd3.olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May hang be done optional? There was a discussion about applying
> "panic" reboot timeout here. Is it possible to implement somehow?

It would be tricky, but might be possible.  But that would be a completely
new feature -- the kernel has always hung in this case. If you think you need 
it submit a (followup) patch. But I don't think it's fair to ask Vivek to do it.

Besides i don't think it would be any useful. panic reboot only
makes sense if you can recover after reboot. But if your CPU somehow
suddenly loses its ability to run 64bit code, no reboot of the world will 
recover.

-Andi
