Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267300AbTGHNoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbTGHNoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:44:32 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:53382 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S267300AbTGHNoa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:44:30 -0400
Date: Tue, 8 Jul 2003 09:59:06 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
Message-ID: <20030708135906.GW16938@kurtwerks.com>
References: <Pine.LNX.4.53.0307071655470.22074@chaos> <20030708003656.GC12127@mail.jlokier.co.uk> <Pine.LNX.4.53.0307080749160.24488@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0307080749160.24488@chaos>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Richard B. Johnson:
> On Tue, 8 Jul 2003, Jamie Lokier wrote:
> 
> > Richard B. Johnson wrote:
> > > mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0xb8000) = 0xb8000
> >
> > You meant to write:
> >
> > 	mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE,
> > 	      MAP_SHARED|MAP_FIXED, 3, 0xb8000 >> 12);
> >
> > The offset argument to mmap2 is divided by PAGE_SIZE.
> > That is the whole point of mmap2 :)
> >
> > -- Jamie
> 
> Okay. Do you know where that's documented? Nothing in linux/Documentation,
> and nothing in any headers. Do you have to read the code to find out?
> 
> So, the address is now the offset in PAGES, not bytes. Seems logical,
> but there is no clue in any documentation.

With the possible exception of the man mmap2 ;-)

DESCRIPTION
       The  function  mmap2  operates  in exactly the same way as
       mmap(2), except that the final argument specifies the off­
       set  into  the  file  in  units  of  the  system page size
       (instead of bytes).  This enables applications that use  a


-- 
"I have a very firm grasp on reality!  I can reach out and strangle it
any time!"
