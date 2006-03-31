Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWCaRSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWCaRSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWCaRSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:18:40 -0500
Received: from ns.suse.de ([195.135.220.2]:24961 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750904AbWCaRSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:18:39 -0500
From: Andi Kleen <ak@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [patch] avoid unaligned access when accessing poll stack
Date: Fri, 31 Mar 2006 19:18:34 +0200
User-Agent: KMail/1.9.1
Cc: Jes Sorensen <jes@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <200603311853.32870.ak@suse.de> <87ek0ipmae.fsf@duaron.myhome.or.jp>
In-Reply-To: <87ek0ipmae.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311918.35207.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 19:16, OGAWA Hirofumi wrote:

> 
> OK. So how about this?
> 
> 	char stack_pps[POLL_STACK_ALLOC]
>         	__attribute__((aligned (sizeof(struct poll_list))));

This would require much more alignment than really necessary. Probably you meant
s/sizeof/alignof/. But Jes' patch is fine I think.

-Andi
