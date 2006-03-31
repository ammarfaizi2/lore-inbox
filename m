Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWCaRkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWCaRkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWCaRkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:40:41 -0500
Received: from mail.parknet.jp ([210.171.160.80]:53511 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932139AbWCaRkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:40:40 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andi Kleen <ak@suse.de>
Cc: Jes Sorensen <jes@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <200603311853.32870.ak@suse.de>
	<87ek0ipmae.fsf@duaron.myhome.or.jp> <200603311918.35207.ak@suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 01 Apr 2006 02:40:34 +0900
In-Reply-To: <200603311918.35207.ak@suse.de> (Andi Kleen's message of "Fri, 31 Mar 2006 19:18:34 +0200")
Message-ID: <87irpums19.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> 	char stack_pps[POLL_STACK_ALLOC]
>>         	__attribute__((aligned (sizeof(struct poll_list))));
>
> This would require much more alignment than really necessary. Probably you meant
> s/sizeof/alignof/. But Jes' patch is fine I think.

I read your this patch now, so, I agree. Sorry for noise.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
