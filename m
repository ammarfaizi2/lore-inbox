Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271392AbRHOUDr>; Wed, 15 Aug 2001 16:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271393AbRHOUDh>; Wed, 15 Aug 2001 16:03:37 -0400
Received: from web12801.mail.yahoo.com ([216.136.174.36]:39687 "HELO
	web12801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271392AbRHOUD1>; Wed, 15 Aug 2001 16:03:27 -0400
Message-ID: <20010815200340.96462.qmail@web12801.mail.yahoo.com>
Date: Thu, 16 Aug 2001 06:03:40 +1000 (EST)
From: =?iso-8859-1?q?Cody=20Gould?= <codygould@yahoo.com.au>
Reply-To: codygould@yahoo.com.au
Subject: ptrace() and clone() status?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// Quick questions about the 2.4 series  
//  
Can a process ptrace() more than one process at  
a time?  ie: Can you PTRACE_ATTACH one process  
to multiple other processes and recieve all of  
their signals?    
  
Also, there was talk some time ago about the  
CLONE_PTRACE flag of clone() being changed to  
send signals to the grandparent process, not  
sending signals to the direct parent.  Was this  
change done?  Is the code working?  
  
If so, would the following be accurate:  
    ptrace(PTRACE_TRACEME, 0, 0, 0);  
    if(fork())   
        ptrace(PTRACE_TRACEME, 0, 0, 0);  
        // Although, for our purposes assume it  
        // actually sent signals to grandparent  
Is the same as:  
    ptrace(PTRACE_TRACEME, 0, 0, 0);  
    clone(CLONE_PTRACE, 0);  
  
I ask because I am having difficulty getting any  
signals from CLONE_PTRACE'd children in my trace  
parent.  Please CC: replies to me as I am not on  
the mailing list.  
  
Thanks,  
Cody Gould  


_____________________________________________________________________________
http://shopping.yahoo.com.au - Father's Day Shopping
- Find the perfect gift for your Dad for Father's Day
