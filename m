Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTHZQY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbTHZQY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:24:57 -0400
Received: from aneto.able.es ([212.97.163.22]:8086 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262818AbTHZQY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:24:56 -0400
Date: Tue, 26 Aug 2003 18:24:54 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: always_inline for gcc3
Message-ID: <20030826162454.GE2023@werewolf.able.es>
References: <Pine.LNX.4.44.0308260850170.3191@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0308260850170.3191@logos.cnet>; from marcelo@conectiva.com.br on Tue, Aug 26, 2003 at 14:15:31 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.26, Marcelo Tosatti wrote:
> 
> Can you please explain me what are the differences when using "__inline__
> __attribute__((always_inline))" and why you chose to use that?
> 

gcc3 did not inline big functions, even if they were marked as inline
Thread:
http://marc.theaimsgroup.com/?t=103632325600005&r=1&w=2
Things like memcpy and copy_to/from_user were affected.
They were not inlined and you got tons of instances in vmlinux.

An initial patch was proposed by Denis Vlasenko, and refined by
akpm I think.

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
