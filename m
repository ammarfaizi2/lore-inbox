Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUGHWCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUGHWCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbUGHWCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:02:42 -0400
Received: from mail.tpgi.com.au ([203.12.160.58]:34238 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263850AbUGHWCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:02:41 -0400
Subject: Re: GCC 3.4 and broken inlining.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200407090036.39323.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
	 <20040708120719.GS21264@devserv.devel.redhat.com>
	 <1089288664.2687.23.camel@nigel-laptop.wpcb.org.au>
	 <200407090036.39323.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1089324043.3098.3.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 09 Jul 2004 08:00:43 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 07:36, Denis Vlasenko wrote:
> It was decided to #define inline so that it means always_inline for lk.
> Dunno why include/linux/compiler-gcc3.h stopped doing that
> specifically for gcc 3.4...

I tried getting it to use the always_inline definition for gcc 3.4. It
resulted in the compilation failing in a number of places. The fixes
were generally trivial, involving rearranging the contents of files so
that inline function bodies appear before routines calling them, or
removing the inline where this isn't possible. IMHO, this is what should
be done. I didn't complete the changes, however: I thought I'd try for a
simpler solution, just in case I'm wrong.

Regards,

Nigel

