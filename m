Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265857AbUFDQxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265857AbUFDQxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUFDQxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:53:44 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12662 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265857AbUFDQxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:53:41 -0400
Date: Fri, 4 Jun 2004 18:57:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] CRIS architecture update
Message-ID: <20040604165715.GB2388@mars.ravnborg.org>
Mail-Followup-To: Mikael Starvik <mikael.starvik@axis.com>,
	'Jeff Garzik' <jgarzik@pobox.com>, 'Andrew Morton' <akpm@osdl.org>,
	'Linux Kernel' <linux-kernel@vger.kernel.org>,
	'Bartlomiej Zolnierkiewicz' <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <BFECAF9E178F144FAEF2BF4CE739C668D0BC1E@exmail1.se.axis.com> <BFECAF9E178F144FAEF2BF4CE739C66818F497@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66818F497@exmail1.se.axis.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 07:46:21AM +0200, Mikael Starvik wrote:
> Hi,
> 
> >Who reviewed the ethernet driver?
> >Who reviewed the IDE driver?
> >Has Bart seen this new driver?
> >Why was this committed without first being run by the subsystem
> maintainers?
> 
> I am very happy if people outside Axis can find time to review patches
> that only affects the CRIS architecture (note that all files are under
> arch/cris and there is no way you can get these drivers unless you run 
> CRIS). I have assumed that people like you and Bart have too much on 
> your hands to do this. The few times I have tried to patch CRIS stuff on 
> LKML the response is usally none.

The general rule is to locate drivers under drivers/, even the arch 
specific ones. This allows for easier grepping after users of a
given API etc.

s390 has their own directory.
arm has their own directory under driver/net/ etc.

With respect to patches, a very good approach is to follow same style
as is done for s390.
Smaller logical splitted patches, being sent out after each kernel release.
This allows LKML readers to do peer review of changes to the IDE driver,
without having to step over a lot of unrelated code.

General rule is to make easy for the reader.


	Sam
