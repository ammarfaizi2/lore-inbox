Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316617AbSFDTVv>; Tue, 4 Jun 2002 15:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSFDTVv>; Tue, 4 Jun 2002 15:21:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:61433 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316617AbSFDTVt>; Tue, 4 Jun 2002 15:21:49 -0400
Subject: Re: Question regarding do_munmap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Popoff <lkml@tre.bloodletting.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <153.25.1023215073895@tre.bloodletting.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 21:27:45 +0100
Message-Id: <1023222465.23874.186.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 19:24, Nick Popoff wrote:
> (Generic 2.4.18 include/linux/mm.h) 
> extern int do_munmap(struct mm_struct *, unsigned long, size_t); 
>  
> (RH 7.3/AC patched 2.4.18-3 include/linux/mm.h) 
> extern int do_munmap(struct mm_struct *, unsigned long, size_t, int 
> acct); 
>  
> My question is what is the recommended way for module developers to 
> handle changes to this API so that end users don't have to edit 
> makefiles to build for their particular kernel?  Is there a way to 

All the -ac trees I ship have -ac in the EXTRAVERSION string. Red Hat
don't propogate that however. I hope to submit the changes to Marcelo
that include the munmap changes for the base tree fairly soon, which
will be ok as its a straight version test. 

I hadn't anticipated people using do_munmap in drivers beyond a couple
of fun bits in the intel 3D acceleration

Alan

