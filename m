Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUJ3WrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUJ3WrB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUJ3WrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:47:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15002 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261375AbUJ3Wqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:46:54 -0400
Date: Sat, 30 Oct 2004 18:46:45 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hamie <hamish@travellingkiwi.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Continual panics... Kernel 2.6.9  - VP6 motherboard dual 866MHz
 PIII
In-Reply-To: <41840F35.9000700@travellingkiwi.com>
Message-ID: <Pine.LNX.4.44.0410301846000.8844-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004, Hamie wrote:

> The main crashes log the following information
> 
> Oct 24 22:17:00 damned REISERFS: panic (device hdb6): journal_begin 
> called without kernel lock held

Looks like a reiserfs bug.  It really should be holding
the kernel lock in journal_begin.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

