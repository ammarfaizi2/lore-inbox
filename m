Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVD2RdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVD2RdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVD2RdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:33:20 -0400
Received: from firewall.kernelslacker.org ([68.162.252.20]:17864 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S262851AbVD2RdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:33:16 -0400
Date: Fri, 29 Apr 2005 13:32:16 -0400
From: Dave Jones <davej@redhat.com>
To: Christopher Warner <chris@servertogo.com>
Cc: Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
       Andi Kleen <ak@suse.de>, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050429173216.GB1832@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christopher Warner <chris@servertogo.com>,
	Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
	Andi Kleen <ak@suse.de>, Chris Wright <chrisw@osdl.org>,
	"Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
	Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114773179.9543.14.camel@jasmine>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 07:12:59AM -0400, Christopher Warner wrote:
 > 
 > > It does.  Well, I needed to restudy exec_mmap and switch_mm in detail,
 > > and having done so, I agree that the only way you can get through
 > > exec_mmap's activate_mm without fully flushing the cpu's TLB, is if
 > > the active_mm matches the newly allocated mm (itself impossible since
 > > there's a reference on the active_mm), and the cpu bit is still set
 > > in cpu_vm_mask - precisely not the case if we went through leave_mm.
 > > Yet I was claiming your leave_mm fix could flush TLB for exec_mmap
 > > where it wasn't already done.
 > > 
 > > Sorry for letting the neatness of my pmd/stack story blind me
 > > to its impossibility, and for wasting your time.
 > > 
 > > Hugh
 > > -
 > 
 > Any updated information one should know about this before testing?
 > 
 > I'm getting bad pmds in 2.6.11.5; Tyan S2882/dual AMD 246 opterons.

Datapoint: exactly the same model as my workstation which showed
this problem recently.

		Dave
