Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264825AbUETD5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbUETD5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 23:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbUETD5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 23:57:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264825AbUETD5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 23:57:48 -0400
Date: Wed, 19 May 2004 20:57:45 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Zhenmin Li" <zli4@cs.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OPERA] Potential bug in /arch/sparc/prom/memory.c & 
 /arch/sparc64/prom/memory.c
Message-Id: <20040519205745.58bc824a.davem@redhat.com>
In-Reply-To: <001201c43e14$73e8c840$76f6ae80@Turandot>
References: <001201c43e14$73e8c840$76f6ae80@Turandot>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004 21:45:03 -0500
"Zhenmin Li" <zli4@cs.uiuc.edu> wrote:

> 158            prom_prom_taken[iter].theres_more =
> !159                    &prom_phys_total[iter+1];
> 158            prom_prom_taken[iter].theres_more =
> !159                    & prom_prom_taken[iter+1];

It's a bug, but luckily harmless as we never actually
walk the link of this table's elements, and in most
other places we only test it against NULL :-)

But I've added the fix to my tree(s), thanks a lot!
