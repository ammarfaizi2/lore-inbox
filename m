Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVD2QAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVD2QAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVD2QAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:00:19 -0400
Received: from mout.perfora.net ([217.160.230.40]:36594 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S262302AbVD2P6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:58:00 -0400
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
From: Christopher Warner <chris@servertogo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: cwarner@kernelcode.com, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com>
References: <20050407062928.GH24469@wotan.suse.de>
	 <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com>
	 <20050414170117.GD22573@wotan.suse.de>
	 <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com>
	 <20050414181015.GH22573@wotan.suse.de>
	 <20050414181133.GA18221@wotan.suse.de>
	 <20050414182712.GG493@shell0.pdx.osdl.net>
	 <20050415172408.GB8511@wotan.suse.de>
	 <20050415172816.GU493@shell0.pdx.osdl.net>
	 <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
	 <20050419133509.GF7715@wotan.suse.de>
	 <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 07:12:59 -0400
Message-Id: <1114773179.9543.14.camel@jasmine>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It does.  Well, I needed to restudy exec_mmap and switch_mm in detail,
> and having done so, I agree that the only way you can get through
> exec_mmap's activate_mm without fully flushing the cpu's TLB, is if
> the active_mm matches the newly allocated mm (itself impossible since
> there's a reference on the active_mm), and the cpu bit is still set
> in cpu_vm_mask - precisely not the case if we went through leave_mm.
> Yet I was claiming your leave_mm fix could flush TLB for exec_mmap
> where it wasn't already done.
> 
> Sorry for letting the neatness of my pmd/stack story blind me
> to its impossibility, and for wasting your time.
> 
> Hugh
> -

Any updated information one should know about this before testing?

I'm getting bad pmds in 2.6.11.5; Tyan S2882/dual AMD 246 opterons. The
problem only occurs when doing some thread intensive task. I'm going to
try and strace/bt and send some information as it occurs. Hardware is
almost identical to the setup above.

-Christopher Warner


