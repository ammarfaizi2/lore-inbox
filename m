Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131194AbRACWES>; Wed, 3 Jan 2001 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131203AbRACWEI>; Wed, 3 Jan 2001 17:04:08 -0500
Received: from box-154.rosh.inter.net.il ([213.8.204.154]:46088 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S131194AbRACWED>;
	Wed, 3 Jan 2001 17:04:03 -0500
Date: Thu, 4 Jan 2001 00:03:25 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.GSO.4.21.0101031648250.17363-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0101040001170.21225-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Alexander Viro wrote:

> > This preliminary, small patch prevents execution of system calls which
> > were executed from a writable segment. It was tested and seems to work,
> > without breaking anything. It also reports of such calls by using printk.
> 
> Get real. Attacker can set whatever registers he needs and jump to one
> of the many instances of int 0x80 in libc. There goes your protection.

But unlike syscalls, offsets inside libc do change. Aren't they?
Programs don't have to use libc, they can be compiled as static.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
