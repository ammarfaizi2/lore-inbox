Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSHSJBG>; Mon, 19 Aug 2002 05:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSHSJBG>; Mon, 19 Aug 2002 05:01:06 -0400
Received: from rj.SGI.COM ([192.82.208.96]:54678 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S318229AbSHSJBF>;
	Mon, 19 Aug 2002 05:01:05 -0400
Message-ID: <3D60B508.B8ABABC6@alphalink.com.au>
Date: Mon, 19 Aug 2002 19:06:16 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kernel Build Mailing List 
	<kbuild-devel@lists.sourceforge.net>
Subject: ANNOUNCE: gcml2 0.7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

gcml2 is (among other things) a Linux kconfig language syntax
checker.  Version 0.7 is available at

http://sourceforge.net/project/showfiles.php?group_id=18813&release_id=106023

and

http://www.alphalink.com.au/~gnb/gcml2/download.html

There's also an online summary of the warnings and errors from the
syntax checker, with real examples, from

http://www.alphalink.com.au/~gnb/gcml2/checker.html

Here's the change log


*  Warnings can be individually enabled.  Default set depends
   on whether the parser is in merge mode. API functions to
   enable/disable warnings by index and convert a string name
   to an index.

*  Added check for define to nonliteral expression.

*  More precise check for ambiguous comparison against "n" only
   complains for symbols which are forward-declared at the point
   when compared.

*  Made inconsistent-tag warnings more precise; doesn't
   emit spurious warnings about define_bool not having an
   (EXPERIMENTAL) tag.

*  More precise check for forward references and forward
   dependencies can tell the difference between forward and
   undeclared, at the cost of some storage.

*  Check for overlapping definitions by reducing conditions to
   disjunctive normal forms.

*  Added check for forward dependencies.

*  Added check for misuse of and dependency on arch-constant
   symbols like CONFIG_X86.

*  Renamed summarise-warnings.awk -> summarize.awk and installed
   it.

*  Added cml-summarize shell script, which runs summarize.awk.

*  Added cml-check-all shell script, based on old dochecks.sh,
   but now also handles running cml-summarize.

*  Added manpages for cml-check, cml-check-all and
   cml-summarize. Description of errors and warnings for the
   cml-check manpage is controlled in HTML and shared with the
   web page.

*  RPM package support: added spec file, rpm: target.


Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
