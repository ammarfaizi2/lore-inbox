Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSFXHMs>; Mon, 24 Jun 2002 03:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSFXHMr>; Mon, 24 Jun 2002 03:12:47 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55311 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317427AbSFXHMq>; Mon, 24 Jun 2002 03:12:46 -0400
Message-ID: <3D16C65F.E67B4471@aitel.hist.no>
Date: Mon, 24 Jun 2002 09:12:31 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
References: <20020619113734.D2658@redhat.com> <E17LF65-0001K4-00@starship> <3D12CFC5.38DD9245@aitel.hist.no> <E17LOzh-0001WB-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> 
> Hashing in htree doesn't work like that - what you're thinking about
> is a traditional fixed-size hash table.  HTree is a btree that uses
> hashes of names as keys.  Each block has a variable amount of the key
> space assigned to it, initially just one block for the entire key
> space.  When that block fills up, its entries and its key space are
> split into two, then those blocks start to fill up, get split, and
> so on.
> 
Very interesting, thanks!

> A hash function that distributes keys better should give somewhat
> better performance, and that has indeed been my experience.  But
> in the case of half-MD4, the improvement we get from better
> distribution is wiped out by the higher cost of computing the hash
> function.[1]  Which is not to say that the work is without value.
> The beautiful distribution given by the half-MD4 hash gives us
> something to aim at, we just have to be more efficient about it.
> 
There is a way to measure the effect of the better but slower
hash.  Add "time-wasting" code to the faster hash so
it gets exactly as slow as MD4.  Then run benchmarks and
see the effects of the better distribution undisturbed.

Helge Hafting
