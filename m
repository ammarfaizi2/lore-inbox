Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750801AbWCYHLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWCYHLm (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 25 Mar 2006 02:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWCYHLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 02:11:42 -0500
Received: from fe7.cox-internet.com ([66.76.2.52]:38892 "EHLO fe7.coxmail.com")
	by vger.kernel.org with ESMTP id S1750801AbWCYHLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 02:11:41 -0500
Message-ID: <4424ED2A.3040006@tamu.edu>
Date: Sat, 25 Mar 2006 01:11:38 -0600
From: Benjamin <benchu@tamu.edu>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Modify the sock Structure!!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I try to modify the sock Structure in sock.h in order to record 
some data!
I just add a unsigned short in the end of the structure. such as:

struct sock {
    /* Socket demultiplex comparisons on incoming packets. */
    __u32            daddr;        /* Foreign IPv4 addr            */
    __u32            rcv_saddr;    /* Bound local IPv4 addr        */

         ...................................................................
        ....................................................................



  void                    (*destruct)(struct sock *sk);
  unsigned short        data;                 /*I put the unsigned short 
here*/
};



 I re-complied the kernel.  The kernel and network functions work 
normally so far.
However, I am a new guy for the kernel programming. I just wonder this 
modification is
safe or not. Is there any side-effect? Or I need to add additional code 
to avoid some unexpected
situation?  Thank you very much!
 
