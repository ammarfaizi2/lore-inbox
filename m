Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTENPot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTENPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:44:49 -0400
Received: from 136.231.118.64.mia-ftl.netrox.net ([64.118.231.136]:10189 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id S261864AbTENPos
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:44:48 -0400
Subject: Re: 2.6 must-fix list, v2
From: Robert Love <rml@tech9.net>
To: Felipe Alfaro Solana <yo@felipe-alfaro.com>
Cc: "Shaheed R. Haque" <srhaque@iee.org>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052910149.586.3.camel@teapot.felipe-alfaro.com>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1050177383.3e986f67b7f68@netmail.pipex.net>
	 <1050177751.2291.468.camel@localhost>
	 <1050222609.3e992011e4f54@netmail.pipex.net>
	 <1050244136.733.3.camel@localhost>
	 <1052826556.3ec0dbbc1d993@netmail.pipex.net>
	 <20030513130257.78ab1a2e.akpm@digeo.com>
	 <1052866156.3ec1766c0b7b3@netmail.pipex.net>
	 <1052910149.586.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1052927975.883.9.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 14 May 2003 11:59:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 07:02, Felipe Alfaro Solana wrote:

> > > > - Add ability to restrict the the default CPU affinity mask so that 
> > > >  sys_setaffinity() can be used to implement exclusive access to a CPU.
> > > 
> > > Why is this useful?
> > 
> > I forgot to add that the result is the rough equivalent of Digital UNIX's psets
> > and Irix's sysmp for my prurposes at least.
> 
> And psets and fencing in Solaris too...

You can get exclusive access with mangling the system call, simply by
having init  bind itself to the non-exclusive processors on boot.

Try it. Every task will then end up on only the non-exclusive
processors.  Seems a very simple change to me, and one that can be done
in user-space.

You do not even have to modify init, if you do not want.  Grab
http://tech9.net/rml/schedutils and put a taskset call in your rc.d

	Robert Love

