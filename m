Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285654AbSADWWp>; Fri, 4 Jan 2002 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285666AbSADWWg>; Fri, 4 Jan 2002 17:22:36 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:1790 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S285498AbSADWWV>;
	Fri, 4 Jan 2002 17:22:21 -0500
Date: Fri, 4 Jan 2002 15:20:56 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andries.Brouwer@cwi.nl
Cc: phillips@bonn-fries.net, acme@conectiva.com.br, ion@cs.columbia.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020104152056.Z12868@lynx.no>
Mail-Followup-To: Andries.Brouwer@cwi.nl, phillips@bonn-fries.net,
	acme@conectiva.com.br, ion@cs.columbia.edu,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200201041516.PAA224847.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <UTC200201041516.PAA224847.aeb@cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Jan 04, 2002 at 03:16:32PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 04, 2002  15:16 +0000, Andries.Brouwer@cwi.nl wrote:
>     sizeof (foo): 1611, sizeof(foo): 19364 => -bs should be removed
>
>     int
>     foo(int x): 11408, int foo(int x): 57275 => -psl should be removed
> 
> I do not think good style is best defined by majority vote.

Certainly not.  However, the Lindent style I'm trying to achieve is that
dictated by Linus.  However, CodingStyle doesn't give all of the details
of how code should be formatted, so I have to look at the code to see
what is actually there.

>     (void *) foo: 11274, (void *)foo: 17062 => -ncs should be added
> 
> Read old kernel sources.
> 
>         de = (struct minix_dir_entry *) (offset + bh->b_data);
> 
> 	:"S" ((long) name),"D" ((long) buffer),"c" (len)
> 
> 	if (32 != sizeof (struct minix_inode))

Well, that's what I was trying to do when I found out that lksr.org
(hosted by innominate.de) was not available.  It seems the -ncs
change is incorrect then (although my preference is to add it - there
doesn't seem to me to be any benefit of having the extra space).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

