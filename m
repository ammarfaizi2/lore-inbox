Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTGGWKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTGGWKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:10:51 -0400
Received: from www.wireboard.com ([216.151.155.101]:20372 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S264536AbTGGWKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:10:50 -0400
To: Andi Kleen <ak@suse.de>
Cc: "Paul Albrecht" <palbrecht@qwest.net>, niv@us.ibm.com,
       linux-kernel@vger.kernel.org, "netdev" <netdev@oss.sgi.com>
Subject: Re: question about linux tcp request queue handling
References: <3F08858E.8000907@us.ibm.com.suse.lists.linux.kernel>
	<001a01c3441c$6fe111a0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F08B7E2.7040208@us.ibm.com.suse.lists.linux.kernel>
	<000d01c3444f$e6439600$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F090A4F.10004@us.ibm.com.suse.lists.linux.kernel>
	<001401c344df$ccbc63c0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<p73fzliqa91.fsf@oldwotan.suse.de>
From: Doug McNaught <doug@mcnaught.org>
Date: 07 Jul 2003 18:25:17 -0400
In-Reply-To: Andi Kleen's message of "07 Jul 2003 23:48:10 +0200"
Message-ID: <m3brw6rn3m.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> "Paul Albrecht" <palbrecht@qwest.net> writes:
> 
> > This statement is inconsistent with the description of this scenario in
> > Steven's TCP/IP Illustrated.  Specifically, continuing the handshake in the
> > TCP layer, i.e., sending a syn/ack and moving to the syn_recd state, is
> > incorrect if the limit of the server's socket backlog would be exceeded.
> > How do you account for this discrepancy between linux and other
> > berkeley-derived implementations?
> 
> The 4.4BSD-Lite code described in Stevens is long outdated. All modern
> BSDs (and probably most other Unixes too) do it in a similar way to what 
> Nivedita described. The keywords are "syn flood attack" and "DoS". 

And furthermore, IIRC, the current Linux networking code is not
Berkeley-derived, though an earlier version was.

-Doug
