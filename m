Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTLJNGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTLJNGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:06:12 -0500
Received: from ssatchell1.pyramid.net ([208.170.252.115]:8858 "EHLO
	ssatchell1.pyramid.net") by vger.kernel.org with ESMTP
	id S262765AbTLJNGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:06:09 -0500
Subject: Answer to Swap performance statistics in 2.6 -- which /proc file
	has it
From: Stephen Satchell <list@satchell.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3FD6F6A8.80907@kubla.de>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
	 <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com>
	 <1070975964.5966.5.camel@ssatchell1.pyramid.net>
	 <Pine.LNX.4.53.0312090854080.8425@chaos>
	 <1070981185.6243.58.camel@ssatchell1.pyramid.net>
	 <Pine.LNX.4.53.0312091014250.525@chaos>  <3FD62845.8090301@kubla.de>
	 <1071019731.8045.31.camel@ssatchell1.pyramid.net> <3FD6F6A8.80907@kubla.de>
Content-Type: text/plain
Message-Id: <1071061566.12344.15.camel@ssatchell1.pyramid.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 05:06:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original question was intended to be this:  the VM swap counters,
originally in /proc/stat, went to which /proc pseudofile?

The answer, as I finally discovered by examining the several versions of
the procps package is /proc/vmstat.

The reason I had problems finding that simple fact has two related
answers.  The first is that the code to generate /proc/vmstat is not
part of /fs/proc as one might expect and as it used to be in 2.4, but is
included in the mm directory where the memory management code lives. 
The second is that the kernel documentation iostats.txt doesn't mention
anything about this particular form of I/O, and there is no document in
Documentation/vm.

I see I have my work cut out for me.  Let me see if I can cobble
together a "patch" this weekend that creates a new file in
Documentation/vm that describes /proc/vmstat for 2.6 and get it
submitted. 

Didn't someone start a Rosetta Stone back in 2.4 for the /proc
filesystem?  Would such a thing be useful in the 2.6 kernel
documentation?  Should I put something together?

The good news is that finding this thing unblocked me so that the
performance monitor I needed to ginidh is now 2.6 ready.

Stephen Satchell

