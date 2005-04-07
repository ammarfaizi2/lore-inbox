Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVDGQrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVDGQrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVDGQrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:47:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262521AbVDGQrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:47:43 -0400
Date: Thu, 7 Apr 2005 12:47:34 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, stsp@aknet.ru,
       linux-kernel@vger.kernel.org, VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050407164734.GB19016@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, stsp@aknet.ru,
	linux-kernel@vger.kernel.org, VANDROVE@vc.cvut.cz
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru> <20050407080004.GA27252@elte.hu> <20050407041006.4c9db8b2.akpm@osdl.org> <Pine.LNX.4.58.0504070737190.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504070737190.28951@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 07:47:41AM -0700, Linus Torvalds wrote:

 > So the sysenter sequence might as well look like
 > 
 > 	pushl $(__USER_DS)	
 > 	pushl %ebp
 > 	sti
 > 	pushfl
 > 	..
 > 
 > which actually does three protected pushes thanks to the one-instruction 
 > "interrupt shadow" after an sti.

Is this guaranteed on every x86 variant (or rather, every one
that has SEP). ?

		Dave

