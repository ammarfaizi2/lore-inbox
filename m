Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUFEXT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUFEXT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUFEXT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:19:57 -0400
Received: from peabody.ximian.com ([130.57.169.10]:36289 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262425AbUFEXTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:19:54 -0400
Subject: Re: clone() <-> getpid() bug in 2.6?
From: Robert Love <rml@ximian.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
References: <40C1E6A9.3010307@elegant-software.com>
	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	 <20040605205547.GD20716@devserv.devel.redhat.com>
	 <20040605215346.GB29525@taniwha.stupidest.org>
	 <1086475663.7940.50.camel@localhost>
	 <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Date: Sat, 05 Jun 2004 19:19:53 -0400
Message-Id: <1086477593.7940.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 16:07 -0700, Davide Libenzi wrote:

> It is likely used by pthread_self(), that is pretty much performance 
> sensitive. I'd agree with Ulrich here.

I think it would want gettid(), not getpid(), for that.  CLONE_THREAD
behavior has getpid() return the same PID for all threads..

	Robert Love


