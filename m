Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUIIX7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUIIX7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUIIX7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:59:54 -0400
Received: from open.hands.com ([195.224.53.39]:26079 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266805AbUIIX7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:59:14 -0400
Date: Fri, 10 Sep 2004 01:10:30 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040910001030.GB7587@lkcl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net> <20040909213813.GC10892@lkcl.net> <20040909164144.F1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909164144.F1924@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 04:41:44PM -0700, Chris Wright wrote:

> > are the sockets in the interrupt context somehow different / special
> > such that they would never get to this code?
> 
> Depends on where the hooks are registered into netfilter whether you'll
> get the inbound stuff.  

 eek!

 e.g. ip_queue definitely gets it because fireflier's userspace code
 is able to determine the program name [from the pid, and it then
 goes hunting through /proc *gibber*] on both incoming and outgoing
 packets.

