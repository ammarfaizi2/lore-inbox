Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269892AbUJGW4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269892AbUJGW4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269872AbUJGWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:55:55 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:16268 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S269854AbUJGWcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:32:47 -0400
In-Reply-To: <20041007215834.GA7047@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain> <001f01c4ac8b$35849710$161b14ac@boromir> <1097160628.31614.68.camel@localhost.localdomain> <20041007215834.GA7047@pclin040.win.tue.nl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CE341A74-18B0-11D9-ABEB-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: mmap specification - was: ... select specification
Date: Thu, 7 Oct 2004 18:32:43 -0400
To: Andries Brouwer <aebr@win.tue.nl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 07, 2004, at 17:58, Andries Brouwer wrote:
> On Thu, Oct 07, 2004 at 03:50:31PM +0100, Alan Cox wrote:
>> "References
>> within the address range starting at pa and continuing for len bytes 
>> to
>> whole pages following the end of an object shall result in delivery 
>> of a
>> SIGBUS signal."
>
> [I read this as follows: If you mmap a file with MAP_SHARED and modify
> the memory at an address so far beyond EOF that it is not in a page
> containing stuff from the file, then you get a SIGBUS. -- Linux does 
> this.
> Also, that if you modify the memory at an address beyond EOF, then
> the file is not modified. -- Again Linux does this.]

The last bit of the SuS text means:

pa <-- len --> eof <-> page boundary

Anywhere from pa to page boundary will generate SIGBUS.  This is a
rather useless definition no?  I think what they meant is:

"References within the address range starting on the first whole page
at least len bytes after pa shall result in delivery of a SIGBUS 
signal."

(I am assuming, of course, that pa is the result of the mmap call. If 
I'm
wrong please tell me, thanks!)

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


