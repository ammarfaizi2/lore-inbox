Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbUJ1Qg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUJ1Qg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUJ1Qg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:36:56 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:63483 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S261740AbUJ1Qg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:36:29 -0400
Subject: Re: set blksize of block device
From: "Shesha B. " Sreenivasamurthy <shesha@inostor.com>
To: Lei Yang <lya755@ece.northwestern.edu>
Cc: LinuxKernel Group <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
In-Reply-To: <41804F04.4000300@ece.northwestern.edu>
References: <417FE6A8.5090803@ece.northwestern.edu>
	 <417FE937.1040304@ece.northwestern.edu>
	 <41804F04.4000300@ece.northwestern.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1098981325.3279.5.camel@arcane>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Oct 2004 09:35:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly you cannot set the block size to lesser than 512. 

When there is a request for the IO, you populate "struct req" data
structure which you will pass it to the kernel or lower level SCSI/SATA
driver. In the "struct req" there is a field "b_size" which may be what
you are interested in. At the user level you can use the IOCTLs to set
the block size of the RAW block device.

-Shesha

On Wed, 2004-10-27 at 18:44, Lei Yang wrote:
> If nobody could answer this question, what about another one? Is there a 
> system call or a kernel interface that would allow me to write a block 
> of data to block 1 of a certain block device?
> 
> Thanks for your reply in advance!
> 
> Lei
> 
> Lei Yang wrote:
> 
> > Please cc me if you have answers to this, I am not on the list. Thanks 
> > a lot!
> >
> > Lei Yang wrote:
> >
> >> Hello,
> >>
> >> I am learning block device drivers and have a newbie question. Given 
> >> a block device, is there anyway that I could set its block size? For 
> >> example, I want to write a block device driver that will work on an 
> >> existing block device.  In this driver, I want block size smaller. 
> >> (The idea looks confusing but I could explain if anybody is 
> >> interested :- )  However,  typically the block size is 1KB, now I 
> >> want to set it to 512 or 256.  Can I do it?
> >>
> >> TIA
> >> Lei
> >>
> >
> >
> >
> 
> 
> 
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
-- 
  .-----.
 /       \
{  o | o  } 
     |
    \_/
      

