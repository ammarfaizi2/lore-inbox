Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267675AbUHEN1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267675AbUHEN1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267677AbUHEN1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:27:09 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:9719 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267675AbUHEN0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:26:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
	<20040804232123.3906dab6.akpm@osdl.org> <4111DC8C.7050504@redhat.com>
	<20040805001737.78afb0d6.akpm@osdl.org> <4111E3B5.1070608@redhat.com>
From: Linh Dang <linhd@nortelnetworks.com>
Organization: Null
Date: Thu, 05 Aug 2004 09:26:45 -0400
In-Reply-To: <4111E3B5.1070608@redhat.com> (Ulrich Drepper's message of
 "Thu, 05 Aug 2004 00:37:25 -0700")
Message-ID: <wn5ekmlyaui.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
> The fast path for all locking primitives etc in nptl today is
> entirely at userlevel.  Normally just a single atomic operation with
> a dozen other instructions.  With the fusyn stuff each and every
> locking operation needs a system call to register/unregister the
> thread as it locks/unlocks mutex/rwlocks/etc.  Go figure how well
> this works.  We are talking about making the fast path of the
> locking primitives two/three/four orders of magnitude more
> expensive.  And this for absolutely no benefit for 99.999% of all
> the code which uses threads.
>

Is there an EFFICIENT way to add priority-inheritance to futex? the
lack of priority-inheritance is biggest headache for RT applications
running on top of NPTL/kernel-2.6. And there's is a LOT more of us (RT
users who want to use NPTL/kernel-2.6) than you might think. I guess
we're just not vocal.

-- 
Linh Dang
