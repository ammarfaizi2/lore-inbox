Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTEFFCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 01:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTEFFCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 01:02:53 -0400
Received: from zero.aec.at ([193.170.194.10]:45832 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262366AbTEFFCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 01:02:52 -0400
Date: Tue, 6 May 2003 07:13:48 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, gj@pointblue.com.pl, bunk@fs.tum.de,
       linux-kernel@vger.kernel.org, ingo.oeser@informatik.tu-chemnitz.de
Subject: Re: 2.5.68-bk11: .text.exit errors in .altinstructions
Message-ID: <20030506051348.GA1338@averell>
References: <20030502171355.GU21168@fs.tum.de> <1052175893.25085.9.camel@nalesnik> <20030506005326.GB18146@averell> <20030505191409.2e2a265c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505191409.2e2a265c.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 04:14:09AM +0200, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > On Tue, May 06, 2003 at 01:04:55AM +0200, Grzegorz Jaskiewicz wrote:
> > > I've got the same problem with 2.5.69:
> > 
> > Use the same workaround. Remove .text.exit from the DISCARD
> > section in your vmlinux.lds.S
> > 
> > Really the problem is unfixable without binutils changes in other
> > ways, sorry.
> 
> How's about we drop .text.exit at runtime, along with .text.init?

Good idea :-) That could work.

-Andi
