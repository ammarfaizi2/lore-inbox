Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUB1AX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbUB1AUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:20:33 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:25214 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263228AbUB1ASI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:18:08 -0500
Date: Fri, 27 Feb 2004 19:18:03 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Paolo Ornati <ornati@fastwebnet.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x: iowait problem while burning a CD
In-Reply-To: <200402271802.51604.ornati@fastwebnet.it>
Message-ID: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Paolo Ornati wrote:

> trying to burn a CD "on the fly" I have noticed a strange thing. During the 
> burning "iowait" remains enough low (~3%, MAX 10%) but, after a little 
> time, it suddenly and quickly goes up to 80-90%: in this condition MKFS 
> seems unable to fill the FIFO buffer as quickly as the CD-writer writes  

> Any ideas?

At that point, mkisofs is probably running into a bazillion
small files, in subdirectories all over the place.

Because a disk seek + track read takes 10ms, it's simply not
possible to read more than maybe 100 of these small files a
second, so mkisofs can't keep up.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

