Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTINOqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 10:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbTINOqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 10:46:49 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:39691 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261165AbTINOqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 10:46:47 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alex Riesen <fork0@users.sf.net>
Subject: Re: 2.6.0-test5-mm1
Date: Sun, 14 Sep 2003 18:01:55 +0400
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20030913091306.GA3658@steel.home> <200309141246.01341.arvidjaar@mail.ru> <20030914135248.GA9729@steel.home>
In-Reply-To: <20030914135248.GA9729@steel.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309141801.55700.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 September 2003 17:52, Alex Riesen wrote:
> Andrey Borzenkov, Sun, Sep 14, 2003 10:46:01 +0200:
> > On Saturday 13 September 2003 13:13, Alex Riesen wrote:
> > > > really-use-english-date-in-version-string.patch
> > > >  really use english date in version string
> > >
> > > -  echo \#define LINUX_COMPILE_TIME \"`LANG=C date +%T`\"
> > > +  echo \#define LINUX_COMPILE_TIME \"`LC_ALL=C LANG=C date +%T`\"
> > >
> > > LC_ALL overrides everything, so LANG is not needed anymore. Should be:
> > >
> > > +  echo \#define LINUX_COMPILE_TIME \"`LC_ALL=C date +%T`\"
> >
> > I need to set three! variables to make man display manpage in english not
> > in russian. I have no idea which variables all versions of date out there
> > respect and which one wins. If you are sure LC_ALL is enough for everyone
> > - so be it.
>
> $ info libc
> ...
> Categories of Activities that Locales Affect
> ...
> `LC_ALL'
>      This is not an environment variable;

please quote the correct part of documentation. LC_ALL is environment 
variable; usually it should win over separate LC_* variables that in turn win 
over LANG. But I repeat - I have no way to verify it for all combinations of 
date/libc/glibc out there; autoconf sets all variables it needs to be on safe 
side so actually instead of removing LANG I'd rather add LC_TIME.

-andrey

 it is only a macro that you
>      can use with `setlocale' to set a single locale for all purposes.
>      Setting this environment variable overwrites all selections by the
>      other `LC_*' variables or `LANG'.

