Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVCDPeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVCDPeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVCDPeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:34:15 -0500
Received: from main.gmane.org ([80.91.229.2]:8893 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262873AbVCDPeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:34:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam <kinema@gmail.com>
Subject: Re: RFD: Kernel release numbering
Date: Fri, 4 Mar 2005 14:29:25 +0000 (UTC)
Message-ID: <loom.20050304T152818-439@post.gmane.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 4.242.171.103 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050225 Firefox/1.0.1)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided to write the following proposal after getting a headache
trying to explain the Linux versioning scheme to a friend of mine.
Only then did I find that the powers that be are talking about the same
thing.  It's far from a complete “engineering standard” but it
makes sense to me.

Disclaimers: INAKD (I am not a kernel developer) and IANASA (I am not a
systems analyst)



<major>.<minor>.<patch>.<bugfix>

<major>	is incremented when user-space ABI is broken.

<minor>	is incremented when there has been a big change/rewrite to one
of the primary subsystems this would include times when for example the
default scheduler was changed or the memory management algorithms were
modifed.

<patch>	is incremented when a smaller change has been made to one of
the primary subsystems, module has been added or depreciated.  Modules
should only be depreciated not be removed from the tree entirely during
a <patch> release removal should be reserved for <minor> releases.
Although it may be tempting to roll fixes that haven't yet been
released in <bugfix> releases this should be avoided.

<bugfix>	is used and incremented as needed when fixing security
vulnerabilities and bugs that cause systems to oops, panic and other
nasty behavior.  Features and speedups should never added in a bugfix
release.


Andrew's -mm tree would still exist though I think it would make sense
if it were renamed to something like -dev or -exp (exp being short for
experimental) to better convey the purpose of the tree to newbie kernel
hackers and PHBs alike.  The policy for this tree would be much more
flexible as a development environment is required to be.  With a
designated development tree and more frequent <minor> release the
odd/even minors could be done away with.  Kernel developers, power
users and other such folk should be encouraged to run the latest
-dev/-exp releases where possible to test out current development
directions.

Although I have no experience with BK it seems to me that the it should
be possible to implement a work flow as described above in any SCM.

--adam

