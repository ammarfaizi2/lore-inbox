Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbTJJRGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTJJRGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:06:06 -0400
Received: from pat.uio.no ([129.240.130.16]:24293 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262968AbTJJRGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:06:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16262.59127.34589.49365@charged.uio.no>
Date: Fri, 10 Oct 2003 13:05:59 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <3F86E51D.3090605@nortelnetworks.com>
References: <20031010122755.GC22908@ca-server1.us.oracle.com>
	<Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org>
	<20031010152710.GA28773@ca-server1.us.oracle.com>
	<20031010160144.GI28795@mail.shareable.org>
	<20031010163300.GC28773@ca-server1.us.oracle.com>
	<3F86E51D.3090605@nortelnetworks.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chris Friesen <cfriesen@nortelnetworks.com> writes:

    >> Platter level doesn't matter.  Storage access level matters.
    >> Node1 and Node2 have to see the same thing.  As long as I am
    >> absolutely sure that when Node1's write() returns, any
    >> subsequent read() on Node2 will see the change (normal barrier
    >> stuff, really), it doesn't matter what happend on the Storage.

     > Isn't that exactly what msync() exists for?

It can't, be used to invalidate the page cache (at least not in the
current implentation) so it won't help you in the above case where you
have 2 nodes writing to the same device.

Cheers,
  Trond
