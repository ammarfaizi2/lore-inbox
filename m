Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTLUAyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTLUAyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:54:50 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:26320 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261909AbTLUAyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:54:49 -0500
Date: Sat, 20 Dec 2003 19:54:45 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: jlnance@unity.ncsu.edu, <linux-kernel@vger.kernel.org>
Subject: Re: Test program with VM or FS problems
In-Reply-To: <20031220080327.2aef4c11.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0312201953550.26393-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Dec 2003, Andrew Morton wrote:

> I bet the use-once page replacement heuristic is doing the wrong thing.  
> I noticed it playing up once - the machine had 30M on the inactive list
> and reading a 40M file repeatedly caused that file to never get cached.  
> it just kept on reclaiming itself.

Hmmm, we'll have to figure out a way to fix this.

A metastable replacement algorithm is sure to make
Roger Luethi's load control stuff harder ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

