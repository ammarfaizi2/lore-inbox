Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUCGNO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbUCGNO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:14:57 -0500
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:32517 "EHLO
	pc16.dolda2000.com") by vger.kernel.org with ESMTP id S261915AbUCGNO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:14:56 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16459.8267.876074.457599@pc7.dolda2000.com>
Date: Sun, 7 Mar 2004 14:14:51 +0100
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP_TOS setsockopt filters away MinCost
In-Reply-To: <20040306223450.1b569ad3.davem@redhat.com>
References: <16458.44160.469394.230025@pc7.dolda2000.com>
	<20040306223450.1b569ad3.davem@redhat.com>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
 > On Sun, 7 Mar 2004 06:00:48 +0100
 > Fredrik Tolf <fredrik@dolda2000.com> wrote:
 > 
 > > This didn't make sense to me. Is there some reason behind this, and
 > > would someone like to explain it to me in that case? I just spent an
 > > hour trying to debug my program to find it why it didn't want to set
 > > minimal cost, while the other three TOS options worked.
 > 
 > Please read the diffserv RFCs for the current meanins of the TOS
 > bits.

Well, I was thinking that it might be diffserv, but on the next line
in that code, it checks the TOS precedence value, so I thought it
can't be. Also, it only resets these bits for SOCK_STREAM sockets - it
doesn't touch SOCK_DGRAMs. Is diffserv still somehow the reason behind
it?

Fredrik Tolf

