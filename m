Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTDXNxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTDXNxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:53:01 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:53799 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263671AbTDXNw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:52:59 -0400
Date: Thu, 24 Apr 2003 09:59:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [ANNOUNCE] desc.c -- dump the i386 descriptor tables
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304241004_MC3-1-35CA-8D5B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:


> > #31: base=c0355600 limit=00eb flags=0089 <G=0 P=1 S=0 DPL=0 Available TSS>
>
> Nice but the limit field is 20 bits (shifted left by 12 bits if G=1).


  Huh.  The diagram I used was blank where the upper four limit bits belong
so I assumed it was unused... and for some reason I was thinking you
shifted
left by 16 bits when G=1, so I never noticed the missing four bits. Thanks.



> Other suggestions left as an exercise to the reader:
> 
> a) distinguish 16 bit code from 32 bit code (GDT entry #19 is 16 bit code),


 BIOS?


> b) distinguish read/write from read-only and execute/read from
> execute-only (are there any read-only or execute-only segments in the GDT?)
> 
> c) distinguish 16 and 32 bit expand down data (changes the upper
> limit of the valid addresses, but it's never used in the GDT, so like
> the conformant code it's not that important)


  I now have it dumping LDTs, and should probably do at least cs:eip and
eflags
for each task.
 

> d) extend this for x86-64 :-)


  Itanium. 8)


------
 Chuck
