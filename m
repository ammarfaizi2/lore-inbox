Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbTDQWrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 18:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDQWrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 18:47:05 -0400
Received: from aneto.able.es ([212.97.163.22]:37599 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262658AbTDQWrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 18:47:04 -0400
Date: Fri, 18 Apr 2003 00:58:50 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Message-ID: <20030417225850.GA17476@werewolf.able.es>
References: <1050569207.1412.1.camel@laptop.fenrus.com> <Pine.LNX.4.44.0304170903001.1530-100000@home.transmeta.com> <20030417191939.GG25696@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030417191939.GG25696@gtf.org>; from jgarzik@pobox.com on Thu, Apr 17, 2003 at 21:19:39 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.17, Jeff Garzik wrote:
> On Thu, Apr 17, 2003 at 09:07:45AM -0700, Linus Torvalds wrote:
[...]
> 
> 	#define memcpy(t, f, n) \
> 	(__builtin_constant_p(n) ? \
> 	 __constant_memcpy3d((t),(f),(n)) : \
> 	 __memcpy3d((t),(f),(n)))
> 

Do you know if this is more efficient ? :

__builtin_choose_expr(__builtin_constant_p(n), ... , ....)

Perhaps ?: reaches runtime, and __builtin doesn't.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-pre7-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
