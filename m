Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTJVE5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 00:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTJVE5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 00:57:10 -0400
Received: from codepoet.org ([166.70.99.138]:50861 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263411AbTJVE5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 00:57:06 -0400
Date: Tue, 21 Oct 2003 22:57:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Nir Tzachar <tzachar@cs.bgu.ac.il>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: srfs - a new file system.
Message-ID: <20031022045708.GA5636@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Nir Tzachar <tzachar@cs.bgu.ac.il>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0310070757400.4688-100000@sundance.cse.ucsc.edu> <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 20, 2003 at 11:12:07AM +0200, Nir Tzachar wrote:
> more info on the system architecture can be find on the web page, and
> here: http://www.cs.bgu.ac.il/~tzachar/srfs.pdf

Suppose I install srfs on both my laptop and my server.  I then
move the CVS repository for my pet project onto the new srfs
filesystem and I take off for the weekend with my laptop.   Over
the weekend I commit several changes to file X.  Over the weekend
my friend also commits several changes to file X.

When I get home and plug in my laptop, presumably the caching
daemon will try to stabalize the system by deciding which version
of file X was changed last and replicating that latest version.  

Who's work will the caching daemon overwrite?  My work, or my
friends work?

Of course, this need not involve anything so extreme as days of
disconnected independent operation.  A rebooting router between
two previously syncd srfs peers seems sufficient to trigger this
kind of data loss, unless you make the logging daemon fail all
writes when disconnected.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
