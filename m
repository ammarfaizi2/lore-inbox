Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVKRT6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVKRT6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVKRT6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:58:21 -0500
Received: from kickapoo.web.itd.umich.edu ([141.211.144.142]:14471 "EHLO
	kickapoo.web.itd.umich.edu") by vger.kernel.org with ESMTP
	id S932370AbVKRT6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:58:21 -0500
Message-ID: <20051118145820.ctd0sliukgwgk080@web.mail.umich.edu>
Date: Fri, 18 Nov 2005 14:58:20 -0500
From: jstipins@umich.edu
To: linux-kernel@vger.kernel.org
Subject: NPTL bug?  2.6.11.12 on an AMD64
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-Remote-Browser: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US;
	rv:1.7.12) Gecko/20050915 Firefox/1.0.7
X-IMP-Server: 141.211.144.244
X-Originating-IP: 71.82.73.173
X-Originating-User: jstipins
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I apologize in advance if this question is inappropriate for this mailing
list.  I welcome any suggestions for a more appropriate forum.

I am running kernel 2.6.11.12 on an AMD Athlon 64, but the kernel is just
the straightforward i486 compilation -- no optimizations, no 64-bit.  The
distribution is LFS 6.1, which apparently runs without any problem.  The
glibc version is 2.3.4, built with gcc 3.4.3.

When I build glibc 2.3.4, 2.3.5, or 2.3.6, using gcc 3.4.3 or 4.0.2, the
"make check" test suite fails exactly one test, which I think may be due
to the kernel.  The "nptl/tst-clock2.c" test fails (in every configuration
listed), and we have:

/sources/glibc-build# cat /sources/glibc-build/nptl/tst-clock2.out
difference between thread 0 and 1 too small (0.053511687)

Here is a link to a person who has reported exactly the same problem,
although he does not indicate if he is using an AMD64 processor:
http://archives.linuxfromscratch.org/mail-archives/lfs-support/2005-August/028065.html

Does anyone have any insight into this problem?  There is next to nothing
on google about it (search on "tst-clock2"), which makes me think it's some
rare combination of processor and kernel.

Again, I welcome any suggestions for a more appropriate forum.  I wanted to
ask here before trying the glibc mailing lists, because they seem pretty clear
about not entertaining build error questions.

Thanks very much for your help,
-Janis
