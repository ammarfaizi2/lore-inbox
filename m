Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291989AbSBAUnO>; Fri, 1 Feb 2002 15:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292002AbSBAUnG>; Fri, 1 Feb 2002 15:43:06 -0500
Received: from antares.in.starshine.org ([216.240.40.177]:25674 "HELO
	antares.in.starshine.org") by vger.kernel.org with SMTP
	id <S291993AbSBAUlj>; Fri, 1 Feb 2002 15:41:39 -0500
From: Jim <jimd@starshine.org>
Date: Fri, 1 Feb 2002 12:33:21 -0800
To: linux-kernel@vger.kernel.org
Subject: Jiffies from userspace
Message-ID: <20020201123321.A799@mars.starshine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Sorry if this question seems stupid, but would this be a 
 reasonable way to get an estimate of the "current" value of the 
 kernel's jiffies:

 	set -- `cat /proc/self/stat`; echo ${22}

 ... my reasoning:

 The cat will start a new process, field 22? of its "stat" node 
 under proc should have the jiffies value at the time the process
 was started; so the echo command execute "shortly" thereafter.

 But am I right about the struct of stat:  Is that really in ${22}?

 (I'm not actually planning on using this technique, it's just a
  curiosity.  The only practical use I can see for it might be for 
  doing a sanity check on gettime; checking this for an increasing 
  value has a hedge against settime discontinuities).

 knfsd: follow symlinks?

 Also, an unrelated question:  is there a way to get the knfsd to
 resolve symlinks on the server side?  (Basically to configure it
 such that it doesn't present symlinks on the underlying fs as 
 symlinks to the client --- but rather it internally follows them,
 and presents the target link/inode data to network clients).  ISTR
 that the older user nfsd used to have some option like that.
 (I realize this second question would be better posed as a separate
 message; oh well).

--
Jim Dennis 
