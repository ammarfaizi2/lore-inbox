Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbUAFFVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUAFFVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:21:11 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:13139 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266064AbUAFFVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:21:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] psmouse info in 2.6.1-rc1
Date: Tue, 6 Jan 2004 00:21:02 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401051711170.23750@student.dei.uc.pt> <200401051317.23795.dtor_core@ameritech.net> <Pine.LNX.4.58.0401051827120.23750@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.58.0401051827120.23750@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401060021.02081.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 January 2004 01:29 pm, Marcos D. Marado Torres wrote:
> > It is psmouse.proto=imps if psmouse is built in the kernel and
> > proto=imps if psmouse is compiled as a module. I mentioned only the
> > first form because I assumed that most people have it built-in.
>
> Weird: I have it built in the kernel and need to do proto=imps and not
> psmouse.proto=imps ...
>

Oh, i see it now... The -mm tree has one obsolete patch that screws up
psmouse module and drops the prefix.

Andrew,

could you please drop the psmouse-parameter-parsing-fix.patch from your
tree as with Vojtech's blessing we are now going into other direction
(modulename.option=value for built-in components and option=value for
modules).

Dmitry
