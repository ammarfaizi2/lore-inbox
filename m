Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280666AbRKFXMS>; Tue, 6 Nov 2001 18:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRKFXMI>; Tue, 6 Nov 2001 18:12:08 -0500
Received: from codepoet.org ([166.70.14.212]:27691 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280666AbRKFXLx>;
	Tue, 6 Nov 2001 18:11:53 -0500
Date: Tue, 6 Nov 2001 16:11:54 -0700
From: Erik Andersen <andersen@codepoet.org>
To: dank@trellisinc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106161154.B32343@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	dank@trellisinc.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011106152215.A31923@codepoet.org> <20011106224753.7D45EA3B90@fancypants.trellisinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011106224753.7D45EA3B90@fancypants.trellisinc.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 06, 2001 at 05:47:53PM -0500, dank@trellisinc.com wrote:
> In article <20011106152215.A31923@codepoet.org> you wrote:
> > Sorry, no doughnut for you.  drivers/block/genhd.c:
> 
> >    #ifdef CONFIG_PROC_FS
> >    int get_partition_list(char *page, char **start, off_t offset, int count)
> >        char buf[64];
> > so each /proc/partitions line maxes out at 63 bytes.  So not only
> > is there no overflow, I am providing 16 extra bytes of padding.
> 
> "code poet?"  you've plucked an 80 from the air.  regardless of what the

Yup, you are right.  You found me out.  I'm a complete impostor
and I know nothing about programming because I spent the exactly
4 seconds to write a simple example without first researching the
underlying interface.  Know why?  Because it was an _example_,
not a dissertation on string processing.  If I was actually going
to write that code, I would have spent the extra two minute it
would have taken to read the kernel source first.  Yes, fixed
buffers suck.  But that is the current interface, so get over it
and get over the pointless ad hominem attacks. 

> constant...", but i work in network security).  others, however,
> may not be so skilled as you, and what of when they're writing
> your server?

Then I should be spending more time interviewing so I don't hire
dolts, and I would spend more time auditing their code and
teaching them how to program. 

I actually avoid using /proc as much as possible in all my code
(I even wrote a patch to replace /proc with a char device about a
year ago, rejected of course for the same reasons Linus expressed
on this thread).  There are many valid reasons why /proc sucks
(especially for embedded systems).  But I don't consider the
ASCII-is-hard-to-parse argument valid.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
