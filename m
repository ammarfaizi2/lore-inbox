Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285126AbRLFNAl>; Thu, 6 Dec 2001 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285129AbRLFNAV>; Thu, 6 Dec 2001 08:00:21 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14604 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285126AbRLFNAR>;
	Thu, 6 Dec 2001 08:00:17 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Niels Christiansen <nchr@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Scalable Statistics Counters 
In-Reply-To: Your message of "Thu, 06 Dec 2001 18:03:53 +0530."
             <20011206180353.E20583@in.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 23:59:57 +1100
Message-ID: <15733.1007643597@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 18:03:53 +0530, 
Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>Hope we can come out with a really cool and acceptable interface..

How about a user space interface that runs at machine speed and
extracts counters without any syscall overhead?  This proposal got very
little attention at the time so we put it aside until more people
were interested.

http://marc.theaimsgroup.com/?l=linux-kernel&m=98578952028153&w=2

Ralf Baechle has pointed out one problem, virtually indexed caches :(.
That prevents a single user space mmap over the scattered kernel pages,
kernel and user space addresses have to be in sync in the cache.  So
user space sees the scattered pages and has to run the structure
itself.  No big deal, just a library function that converts an instance
name and cpu number into an address.

