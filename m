Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTJUMRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTJUMRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:17:15 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:62643 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263085AbTJUMRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:17:10 -0400
Message-ID: <131e01c397cd$082ea3b0$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: RH7.3 can't compile 2.6.0-test8
Date: Tue, 21 Oct 2003 21:14:55 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland wrote:
> On Monday October 20th 2003 at 16:01 Christian Kujau wrote:
> > Norman Diamond schrieb:
> > [...]
> > > [ndiamond@c1pc40 linux-2.6.0-test8]$ gcc -v
> > > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > > gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
> > > [ndiamond@c1pc40 linux-2.6.0-test8]$ rpm -qa binutils
> > > binutils-2.11.93.0.2-11
> >
> > did you try with a gcc 3.x too? perhaps it's (only) a compiler issue...
>
> No, you just need to upgrade binutils to version 2.12 or higher, as
> mentioned in Documentation/Changes. The gcc version is fine.

I disagree with both of you.

I downloaded binutils, I think 2.14.96.0 or thereabouts (I'm away from the
machine now).  It rejected rpm -U because it depends on a version of
glibc-devel which is newer than RH 7.3's version of glibc-devel.  I didn't
examine yet whether it is possible to upgrade glibc-devel without upgrading
gcc, and didn't download any version of those yet in order to try binutils
again.

The Readme for 2.6.0-test6 still said that gcc 2.95 is required (I confess
to not reading Readme for test8 yet.)   I reported a compilation problem in
test6 using gcc 3.2.something in SuSE on a different machine, and it seems
believable that gcc 2.95 is still required.  As mentioned at the beginning
of this thread, I understand that Red Hat's gcc 2.96 is nonstandard.  If I
make any changes to binutils and glibc-devel and gcc, surely it should be to
install gcc 2.95 and related packages which would be compatible with that
version.  It should not be to install gcc 3.anything, or glibc-devel or
binutils that depend on it.

