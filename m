Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285359AbRLFWfa>; Thu, 6 Dec 2001 17:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285349AbRLFWfI>; Thu, 6 Dec 2001 17:35:08 -0500
Received: from bitmover.com ([192.132.92.2]:52612 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285277AbRLFWcU>;
	Thu, 6 Dec 2001 17:32:20 -0500
Date: Thu, 6 Dec 2001 14:32:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Daniel Phillips <phillips@bonn-fries.net>,
        "David S. Miller" <davem@redhat.com>, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206143218.O27589@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	"David S. Miller" <davem@redhat.com>, davidel@xmailserver.org,
	rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com,
	riel@conectiva.com.br, lars.spam@nocrew.org, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206121004.F27589@work.bitmover.com> <E16C79j-0003LO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16C79j-0003LO-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 06, 2001 at 10:38:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 10:38:14PM +0000, Alan Cox wrote:
> > the hardware's coherency.  No locks in the vfs or fs, that's all done
> > in the mmap/page fault path for sure, but once the data is mapped you
> > aren't dealing with the file system at all.
> 
> ftruncate

I'm not sure what the point is.  We've already agreed that the multiple OS
instances will have synchonization to do for file operations, ftruncate
being one of them.

I thought the question was how N user processes do locking and my answer
stands: exactly like they'd do it on an SMP, with mutex_enter()/exit() on
some portion of the mapped file.  The mapped file is just a chunk of cache
coherent memory.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
