Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265859AbUFDQmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUFDQmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUFDQmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:42:52 -0400
Received: from [213.146.154.40] ([213.146.154.40]:19623 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265859AbUFDQkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:40:41 -0400
Date: Fri, 4 Jun 2004 17:40:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       luto@myrealbox.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       akpm@osdl.org, suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040604164032.GA2331@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, luto@myrealbox.com,
	mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@osdl.org,
	suresh.b.siddha@intel.com, jun.nakajima@intel.com
References: <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604154142.GF16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org> <20040604155138.GG16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org> <20040604181304.325000cb.ak@suse.de> <20040604163753.GN16897@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604163753.GN16897@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 06:37:54PM +0200, Arjan van de Ven wrote:
> Fedora makes the heap non executable too; it only broke X which has it's own
> shared library loader (which btw had all the right mprotects in place, just
> ifdef'd for freebsd, ia64 and a few other architectures that default to
> non-executable heap, so we just added x86(-64) to that)

Maybe you should just call mprotect always to be safe? :)  OTOH I guess
the world would end if a X release had less ifdefs than the previous one..
