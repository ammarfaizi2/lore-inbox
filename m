Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUJNK1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUJNK1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUJNK1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:27:16 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:16273 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S266663AbUJNK1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:27:13 -0400
Date: Thu, 14 Oct 2004 10:27:12 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Documentation approach bugreport.
Message-ID: <20041014102712.GC8837@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel documentation redirects the user sometimes to manpages which is
a bad practice according to my opinion, which I am going to explain why
later.

make menuconfig, Loadable module support,  Enable loadable module support,
< Help >: "For more information, see the man pages for               x   
  modprobe, lsmod, modinfo, insmod and rmmod."

There are various reasons why I think this is a bad practice:
* Linux is a kernel. The place where Linux ends and other things (like programs)
  begin lies in a syscall modprobe makes. The user could use another
  program that complies to the same interface specification and does the same
  job as insmod, modprobe etc. If he used such a program, he wouldn't
  need neither modprobe nor insmod on his system and logically wouldn't have
  installed corresponding manpages. The redirect in the Linux documentation
  in the <Help> would be invalid then.
* Sometimes Linux is used in a restricted environment for example embedded
  system where the manpages would take up unnecessary space and are omitted
  for this reason. The redicrect in the Linux documentation would be invalid
  then too.
* Manpages are different project than Linux. It isn't then clear, if e. g. man
  modprobe contains a bug, whether it should be reported to them or to Linux.
* Linux kernel is subject to changes as well as manpages are. They are being
  on the system independently and it easily becomes that manpages get out of
  sync with Linux kernel. Then the pointed-to information could be
  too old or too new (for example when old Linux version is being employed
  for some technical reason). 

I suggest the following:
* the manpage pointers to be removed and the information that is being referred
  to be copied into Linux source tree and further maintained there
* If the above should prove too much burden for the size of the source tarball
  , separate information page to be made on http://www.kernel.org in the style
  of Exim 4.40 Specification http://exim.org/exim-html-4.40/doc/html/spec.html

Cl<
