Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbSKTBvp>; Tue, 19 Nov 2002 20:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSKTBvp>; Tue, 19 Nov 2002 20:51:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30481 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267135AbSKTBvp>; Tue, 19 Nov 2002 20:51:45 -0500
Date: Tue, 19 Nov 2002 17:59:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
In-Reply-To: <3DDAE822.1040400@redhat.com>
Message-ID: <Pine.LNX.4.44.0211191757560.27118-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Nov 2002, Ulrich Drepper wrote:
> 
> could you please make a decision regarding this?  I'd like to make a new
> nptl release which fixes the bug this patch helps to fix so that we get
> testing (also of the kernel issues).
> 
> Ingo's last patch has two pointer

Ingo's patch (a) doesn't apply any more and (b) was broken anyway. It 
sets the child tidptr from the parent _after_ doing the copy_mm(), so the 
child setting doesn't work at all for the non-CLONE_VM case. So I don't 
have any decision to make.

		Linus

