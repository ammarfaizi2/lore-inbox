Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUJEXr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUJEXr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJEXr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:47:29 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:41293 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266362AbUJEXr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:47:27 -0400
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 05 Oct 2004 16:47:21 -0700
In-Reply-To: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com> (Richard
 B. Johnson's message of "Tue, 5 Oct 2004 18:58:24 -0400 (EDT)")
Message-ID: <52vfdoraly.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Linux-2.6.5-1.358 SMP
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 05 Oct 2004 23:47:26.0306 (UTC) FILETIME=[AAF5AC20:01C4AB35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> I need to make some modules that have lots of assembly
    Richard> code.  This assembly uses the UNIX calling convention and
    Richard> can't be re-written (it would take many months). The new
    Richard> kernel is compiled with "-mregparam=2". I can't find
    Richard> where that's defined. I need to remove it because I
    Richard> cannot pass parameters to the assembly stuff in
    Richard> registers.

You should be able to use CONFIG_REGPARM to control this.  Another
option is just to mark the functions in your source as "asmlinkage"
(which is defined to "__attribute__((regparm(0)))" in
asm-i386/linkage.h).  The advantage of using asmlinkage is that your
code will work with anyone's kernel.

 - Roland

