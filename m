Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTJAOR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJAOR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:17:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29327 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262232AbTJAOR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:17:26 -0400
Date: Wed, 1 Oct 2003 15:17:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>, socrate@infoiasi.ro
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification for binaries
Message-ID: <20031001141718.GT7665@parcelfarce.linux.theplanet.co.uk>
References: <3F733FD3.60502@ericsson.ca> <20031001102631.GC398@elf.ucw.cz> <3F7AD795.1040001@ericsson.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7AD795.1040001@ericsson.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 09:33:09AM -0400, Makan Pourzandi wrote:
 
> Third, the intruder now has access to the system, he cannot execute the 
> code he brought in with himself (not signed) or he cannot bring it in 
> (c.f. above). So he needs to compile the code on the system. AFAIK, for 
> the absolute majority of servers the admins remove all compilers 
> (specially gcc) on all servers. this is for several different security 
> reasons  (I don't want to get there). therefore, the above hypothesis 
> gets even more difficult to realize. 

Don't be ridiculous.  It's trivial to exploit a local buffer overrun in
one of your signed binaries and have the shellcode mmap the rest.  All
pre-built, of course.

> Last, but I believe the most important, the level of difficulty of 
> execution of such an attack is much higher than the average knowledge 
> level of many script kiddies. The absolute majority of attackers have 
> little or absolutely not any knowledge of the operating systems in 
> general and linux in particular, let aside the knowledge of writing a C 
> program, calling mmaps in that progam and run the malicious code to gain 
> access as root, then remove the module to execute a classical attack.
> 
> There is no such thing as 100% secure system, digsig increases the level 
> of security of the system as it just makes it much more difficult for 
> the intruder to succeed in his/her attack.

Rubbish.  You don't need to compile anything locally and the rest will be
done once by some wanker with half a clue and then repeated by wankers
without a clue (aka script kiddies).
