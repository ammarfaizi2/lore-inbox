Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271245AbTGWVVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271330AbTGWVVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:21:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24584 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271245AbTGWVVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:21:08 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: devfsd/2.6.0-test1
Date: 23 Jul 2003 21:28:43 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfmumb$l7l$1@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030717183139.17023B-100000@gatekeeper.tmr.com> <1058718448.19817.5.camel@nosferatu.lan>
X-Trace: gatekeeper.tmr.com 1058995723 21749 192.168.12.62 (23 Jul 2003 21:28:43 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1058718448.19817.5.camel@nosferatu.lan>,
Martin Schlemmer  <azarah@gentoo.org> wrote:
| 
| --=-7Lt6k6a+JkixQBaZzKBJ
| Content-Type: text/plain
| Content-Transfer-Encoding: quoted-printable
| 
| On Fri, 2003-07-18 at 00:39, Bill Davidsen wrote:
| > On 17 Jul 2003, Martin Schlemmer wrote:
| >=20
| > > On Thu, 2003-07-17 at 11:17, Mark Watts wrote:
| >=20
| > > > I'm running devfs on a 2.6.0-test1 box (Mandrake 9.1 with the new ker=
| nel)
| > > >=20
| > > > Every time I boot, it complains that I don't have an /etc/modprobe.de=
| vfs.
| > > > If I symlink modules.devfs, I get a wad of errors about 'probeall'.
| > > > What should a modprobe.devfs look like for a 2.5/6 kernel?
| > > >=20
| > >=20
| > > The module-init-tools tarball should include one.
| >=20
| > Agreed, it should. However, the last version I pulled had zero support fo=
| r
| > probeall, and more importantly for probe, which is somewhat harder to do
| > cleanly without having to rewrite the config file for each kernel you
| > boot.
| >=20
| 
| Well, it implements probeall in another fashion.  Also, you might
| try /sbin/generate-modprobe.conf to convert a modules.conf to
| modprobe.conf syntax.

Doesn't seem to convert "probe" unless there's a *very* new version, it
converted my eight line modules.conf including probe to 113 lines of
code I need to edit before rebooting.

The problem has been that certain drivers take turns working in the 2.5
evolution, e100 and eepro for instance. So if I have e100 I want to load
it, otherwise try eepro. That's what probe is all about, and I can boot
one kernel or another, regardless of which driver works (or is compiled)
in a given kernel.

Seems like a giant step backward to drop useful functionality, but 2.4
will be around for a long time.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
