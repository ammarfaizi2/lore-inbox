Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUBNPts (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 10:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUBNPts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 10:49:48 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:5134 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262050AbUBNPtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 10:49:46 -0500
Date: Sat, 14 Feb 2004 17:02:44 +0100
To: Andrew Gray <grayaw@egr.unlv.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fh_verify: no root_squashed access hundreds of times a second again
Message-ID: <20040214160244.GA23147@hh.idb.hist.no>
References: <1076692518.15751.5.camel@blargh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076692518.15751.5.camel@blargh>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 09:18:32AM -0800, Andrew Gray wrote:
> I'm not subscribed to the linux-kernel list, I would appreciate a CC on
> any replies, but I will be watching the list as well.  I'm reposting
> this message in the hope someone will answer - neither I nor the mailing
> list got any replies last time.
> 
> I am using kernel 2.4.24 on a heavily-used NFS server. I am receiving
> hundreds of messages like:
> 
> "kernel: fh_verify: no root_squashed access at sessions/lastsession."
> 
> in my messages log, usually accompanied by a "last message repeated 6497
> times" a minute or so later. I'm gathering it is just reporting it is
> denying root access to a share, which is fine and exactly what I asked
> for. Is there anyway to shut this logging off without just wiping the
> line from fs/nfsd/nfsfh.c? 

How about tracking down whoever is trying to do all these illegal
accesses and stop them?  6000 attempts per minute seems a
waste of resources, whether malicious or ill-configured. 

Helge Hafting
