Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSJURuT>; Mon, 21 Oct 2002 13:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJURuT>; Mon, 21 Oct 2002 13:50:19 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30901 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261568AbSJURuQ> convert rfc822-to-8bit; Mon, 21 Oct 2002 13:50:16 -0400
Subject: Re: System call wrapping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Henr=FD_=DE=F3r?= Baldursson <henry@f-prot.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035222121.1063.20.camel@pc177>
References: <1035222121.1063.20.camel@pc177>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 19:12:09 +0100
Message-Id: <1035223929.27309.234.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 18:42, Henrý Þór Baldursson wrote:
> In our Windows product we have something called "Realtime protector"
> which monitors file access on Windows running machines and scans them
> before allowing access. 

So what you want to do is get notification of new file creations ?

> sys_call_table[__NR_open]. We did realize that this is a bad idea if a
> user loads another module doing the same, and then unloads in the wrong
> order. And also that this is not a very pretty method. But it worked. 

Its also useless because I can switch paths around under your analyser
and fool you into missing things. Wrappers dont work, its also why snare
is so limited in value for example.

There are interfaces for monitoring directories for new file creations -
using things like dnotify from user space. They may be sufficient, but
if not the right question is "how do we make a real solution work" not
how do we hack half working tricks into syscall entry points.

> compile a new kernel.  Is there some API for wrapping system calls which
> I am unaware of, or are there plans to provide one? 

In general there isnt, nor should there need to be.


