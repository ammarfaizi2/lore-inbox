Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbUJZHdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUJZHdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbUJZHdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:33:36 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:52235 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262153AbUJZHdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:33:07 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
Subject: Re: The naming wars continue...
Date: Tue, 26 Oct 2004 10:32:48 +0300
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041025232654.GC30574@thundrix.ch> <clkrak$rtl$1@terminus.zytor.com>
In-Reply-To: <clkrak$rtl$1@terminus.zytor.com>
Cc: Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410261032.34133.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 09:37, H. Peter Anvin wrote:
> Followup to:  <20041025232654.GC30574@thundrix.ch>
> By author:    Tonnerre <tonnerre@thundrix.ch>
> In newsgroup: linux.dev.kernel
> > 
> > Salut,
> > 
> > On Sun, Oct 24, 2004 at 03:33:33PM +0200, Helge Hafting wrote:
> > > Yes - lets stick to fewer numbers.  They can count faster, instead
> > > of having a long string of them.  I hope linux doesn't
> > > end up like X. "X11R6.8.1" The "X" itself is a counter, although
> > > it is understandable if it never increments to "Y".  But
> > > that "11" doesn't change much, and then there are three more numbers. :-/
> > 
> > X11  is the  name of  the  protocol: the  X Protocol,  version 11,  as
> > released by the MIT. There was an X10.
> > 
> 
> There also were a W, and and X1, X2, ... X11.
> 
> However, there is a tendency for numbers to get stuck (witness Linux
> 2.x).  In particular, X11R6 got encoded in many places including
> pathnames for no good reason.  Under the pre-R6 naming schemes we'd
> had R7 a long time ago.

How true.

# pwd
/usr/src2/uClibc-0.9.26
# grep -r X11R6 .
./ldso/ldso/readelflib1.c:                      UCLIBC_RUNTIME_PREFIX "usr/X11R6/lib:"
./utils/ldd.c:  path =  UCLIBC_RUNTIME_PREFIX "usr/X11R6/lib:"
./utils/ldconfig.c:         scan_dir(UCLIBC_RUNTIME_PREFIX "/usr/X11R6/lib");
./libpthread/linuxthreads/README.Xfree3.2:This file describes how to make a threaded X11R6.
./libpthread/linuxthreads/README.Xfree3.2:You need the source-code of XFree-3.2. I used the sources of X11R6.1
./libpthread/linuxthreads/README.Xfree3.2:cp XF3.2/xc/lib/*/*.so.?.? /usr/X11R6/lib/
./libpthread/linuxthreads/README.Xfree3.2:cd /usr/X11R6/lib/
./Changelog:    o Made the lib loader also support libs in /usr/X11R6/lib by default

This should be removed.

cd /usr/lib; ln -s /usr/X11R6/* .
	or
echo /usr/X11R6/lib >>/etc/ld.so.conf

are the better ways to handle this
(I use first one)
--
vda

