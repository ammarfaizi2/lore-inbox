Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUBKU2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUBKU2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:28:54 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:41140 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265289AbUBKU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:28:53 -0500
Date: Wed, 11 Feb 2004 15:28:51 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jon Burgess <lkml@jburgess.uklinux.net>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
In-Reply-To: <402A7CA0.9040409@jburgess.uklinux.net>
Message-ID: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.44.0402111528142.23220@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004, Jon Burgess wrote:

> Write speed in MB/s using an ext2 filesystem for 1 and 2 streams:
> Num streams:     1      2
> linux-2.4.22   10.47  6.98
> linux-2.6.2     9.71  0.34

> During the disk light is on solid and it really slows any other disk 
> access. It looks like the disk is continuously seeking backwards and 
> forwards, perhaps re-writing the meta data.

Just for fun, could you also try measuring how long it takes
to read back the files in question ?

Both individually and in parallel...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

