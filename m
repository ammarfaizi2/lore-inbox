Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRAVOJT>; Mon, 22 Jan 2001 09:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131443AbRAVOJJ>; Mon, 22 Jan 2001 09:09:09 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:49294 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130431AbRAVOJE>; Mon, 22 Jan 2001 09:09:04 -0500
Date: Mon, 22 Jan 2001 15:09:01 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andi Kleen <ak@suse.de>
Cc: Sandy Harris <sandy@storm.ca>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: md= broken. Found problem. Can't fix it.  : (
Message-ID: <20010122150901.C1173@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A6A044F.7974AF67@psychosis.com> <3A6A0A20.18362B90@storm.ca> <20010120232851.A10166@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010120232851.A10166@gruyere.muc.suse.de>; from ak@suse.de on Sat, Jan 20, 2001 at 11:28:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 11:28:51PM +0100, Andi Kleen wrote:
> On Sat, Jan 20, 2001 at 04:58:56PM -0500, Sandy Harris wrote:
> > I suspect that I've misunderstood some constraint here. Perhaps the more complex
> > code you posted is necessary, but I'd like to know why.
> 
> strtok is not reentrant and cannot be nested this way without 
> saving __strtok. strsep would work.

But be careful:

strsep() in kernel skips zero length strings, but strsep 
glibc wouldn't do.

Regards

Ingo Oeser

Note: I implemented it to replace strtok and even did a patch to
   replace all occourences of it, but got no response and so stopped
   working on this issue. If there is still interest, I would do
   it again.
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
