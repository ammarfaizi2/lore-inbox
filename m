Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbTGGVep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264844AbTGGVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:34:44 -0400
Received: from ns.suse.de ([213.95.15.193]:55567 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266276AbTGGVdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:33:37 -0400
To: "Paul Albrecht" <palbrecht@qwest.net>
Cc: niv@us.ibm.com, linux-kernel@vger.kernel.org,
       "netdev" <netdev@oss.sgi.com>
Subject: Re: question about linux tcp request queue handling
References: <3F08858E.8000907@us.ibm.com.suse.lists.linux.kernel>
	<001a01c3441c$6fe111a0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F08B7E2.7040208@us.ibm.com.suse.lists.linux.kernel>
	<000d01c3444f$e6439600$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F090A4F.10004@us.ibm.com.suse.lists.linux.kernel>
	<001401c344df$ccbc63c0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Jul 2003 23:48:10 +0200
In-Reply-To: <001401c344df$ccbc63c0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
Message-ID: <p73fzliqa91.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Albrecht" <palbrecht@qwest.net> writes:

> This statement is inconsistent with the description of this scenario in
> Steven's TCP/IP Illustrated.  Specifically, continuing the handshake in the
> TCP layer, i.e., sending a syn/ack and moving to the syn_recd state, is
> incorrect if the limit of the server's socket backlog would be exceeded.
> How do you account for this discrepancy between linux and other
> berkeley-derived implementations?

The 4.4BSD-Lite code described in Stevens is long outdated. All modern
BSDs (and probably most other Unixes too) do it in a similar way to what 
Nivedita described. The keywords are "syn flood attack" and "DoS". 

-Andi
