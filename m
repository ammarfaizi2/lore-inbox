Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132353AbRADBwl>; Wed, 3 Jan 2001 20:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRADBwc>; Wed, 3 Jan 2001 20:52:32 -0500
Received: from Cantor.suse.de ([194.112.123.193]:63236 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129267AbRADBwW>;
	Wed, 3 Jan 2001 20:52:22 -0500
Date: Thu, 4 Jan 2001 02:51:53 +0100
From: Andi Kleen <ak@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
Message-ID: <20010104025153.A15359@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org> <Pine.GSO.4.21.0101031648250.17363-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101031648250.17363-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jan 03, 2001 at 04:54:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 04:54:38PM -0500, Alexander Viro wrote:
> 
> Win: 0
> Loss: cost of find_vma() (and down(&mm->mmap_sem), BTW) on every system

It could actually be optimized a lot, e.g. by just read/writing to a byte
in the caller's current code page and handling the exception. 

But I agree with you that it's rather useless. It'll break some existing 
exploits, but it's so easy to workaround that exploit writers would quickly
adapt and then you have a ugly check with no purpose after a few weeks.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
