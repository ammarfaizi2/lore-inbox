Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282814AbRLGIdr>; Fri, 7 Dec 2001 03:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285426AbRLGIdh>; Fri, 7 Dec 2001 03:33:37 -0500
Received: from ns.suse.de ([213.95.15.193]:62468 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282814AbRLGId3> convert rfc822-to-8bit;
	Fri, 7 Dec 2001 03:33:29 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: vma->vm_end > 0x60000000
In-Reply-To: <Pine.LNX.4.10.10010311645420.400-100000@cassiopeia.home>
	<20011206191734.B818@holomorphy.com>
X-Yow: ..  Once upon a time, four AMPHIBIOUS HOG CALLERS attacked a family
 of DEFENSELESS, SENSITIVE COIN COLLECTORS and brought DOWN their
 PROPERTY VALUES!!
From: Andreas Schwab <schwab@suse.de>
Date: 07 Dec 2001 09:33:12 +0100
In-Reply-To: <20011206191734.B818@holomorphy.com> (William Lee Irwin III's message of "Thu, 6 Dec 2001 19:17:34 -0800")
Message-ID: <jevgfj8m5z.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

|> On Tue, Oct 31, 2000 at 04:48:11PM +0100, Geert Uytterhoeven wrote:
|> > In fs/proc/array.c:proc_pid_statm() there is this test block:
|> > 
|> >     if (vma->vm_flags & VM_EXECUTABLE)
|> > 	    trs += pages;   /* text */
|> >     else if (vma->vm_flags & VM_GROWSDOWN)
|> > 	    drs += pages;   /* stack */
|> >     else if (vma->vm_end > 0x60000000)
|> > 	    lrs += pages;   /* library */
|> >     else
|> > 	    drs += pages;
|> > 
|> > Is there any special reason for the hardcoded constant `0x60000000'?
|> > In the Linux/m68k tree, we use TASK_UNMAPPED_BASE instead. But I don't know
|> > why.
|> 
|> I think this is an old x86 load address for an ELF interpreter.

No, it is a leftover from the a.out times.  IMHO it should be removed
completely.  "Library pages" has no meaning for ELF.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
