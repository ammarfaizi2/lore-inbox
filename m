Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUDSA0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 20:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUDSA0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 20:26:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41655 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264218AbUDSA0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 20:26:19 -0400
Date: Sun, 18 Apr 2004 20:26:13 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marc Singer <elf@buici.com>
cc: Andrew Morton <akpm@osdl.org>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: vmscan.c heuristic adjustment for smaller systems
In-Reply-To: <20040418061529.GF19595@flea>
Message-ID: <Pine.LNX.4.44.0404182025290.10183-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004, Marc Singer wrote:

> I thought I sent a message about this.  I've found that the problem
> *only* occurs when there is exactly one process running.

BINGO!  ;)

Looks like this could be the referenced bits not being
flushed from the MMU and not found by the VM...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

