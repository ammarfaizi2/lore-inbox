Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbTGIKdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268173AbTGIKdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:33:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:50092 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S268149AbTGIKaR
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:30:17 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.61989.920240.358179@laputa.namesys.com>
Date: Wed, 9 Jul 2003 14:44:53 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5 VM changes: dont-rotate-active-list.patch
In-Reply-To: <20030709031217.21b54196.akpm@osdl.org>
References: <16139.54928.435252.933882@laputa.namesys.com>
	<20030709031217.21b54196.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > > This patch modifies refill_inactive_zone() so that it scans active_list
 > >  without rotating it. 
 > 
 > I'm unconvinced.  The scanning of the active list allows us to keep the
 > referenced state uptodate and balanced across all pages.
 > 

With this patch active list is still scanned. The only difference is
that in !reclaim_mapped mode, mapped but unreferenced pages are left
behind scanning point instead of being thrown to the head of active list
(which supposed to be LRU, after all).

Nikita.
