Return-Path: <linux-kernel-owner+w=401wt.eu-S1751819AbXAVAgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbXAVAgl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 19:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXAVAgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 19:36:41 -0500
Received: from smtpout.mac.com ([17.250.248.186]:57397 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbXAVAgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 19:36:40 -0500
In-Reply-To: <ep0tb0$f6e$1@taverner.cs.berkeley.edu>
References: <87r6toufpp.wl@betelheise.deep.net> <ep0tb0$f6e$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1D317613-B0B6-4517-81B5-DBF3978FA413@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       Samium Gromoff <_deepfire@feelingofgreen.ru>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] Undo some of the pseudo-security madness
Date: Sun, 21 Jan 2007 19:36:27 -0500
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 21, 2007, at 18:34:56, David Wagner wrote:
> [1] In comparison, suidperl was designed to be installed setuid- 
> root, and it takes special precautions to be safe in this usage.   
> (And even it has had some security vulnerabilities, despite its  
> best efforts, which illustrates how tricky this business can be.)   
> Setting the setuid-root bit on a large complex interpreter that  
> wasn't designed to be setuid-root seems like a pretty dubious  
> proposition to me.

Well, there's also the fact that Linux does *NOT* need suidperl, as  
it has proper secure support for suid pound-bang scripts anyways.   
The only reason for suidperl in the first place was broken operating  
systems which had a race condition between the operating system  
checking the suid bits and reading the '#! /usr/bin/perl' line in the  
file, and the interpreter getting executed and opening a different  
file (think symlink redirection attacks).  I believe Linux jumps  
through some special hoops to ensure that can't happen.

Cheers,
Kyle Moffett

