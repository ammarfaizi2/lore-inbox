Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262444AbSJESfv>; Sat, 5 Oct 2002 14:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbSJESfv>; Sat, 5 Oct 2002 14:35:51 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:64133 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262444AbSJESfu> convert rfc822-to-8bit; Sat, 5 Oct 2002 14:35:50 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40 (BK of today) vmstat SIGSEGV after reading /proc/stat
Date: Sat, 5 Oct 2002 20:41:18 +0200
User-Agent: KMail/1.4.7
Cc: Robert Love <rml@tech9.net>, Patrick Mau <Patrick.Mau@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210052041.18854.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 5. Oktober 2002 17:59 schrieb Robert Love:
> On Sat, 2002-10-05 at 13:12, Patrick Mau wrote:
>
> > The BK tree of today changed the data returned in /proc/stat.
> > A 'vmstat -n 10' immediatly segfaults after reading ...
> >
> > open("/proc/stat", O_RDONLY)            = 6
> > read(6, "cpu  404408 506514 8240 154301 1"..., 4095) = 714
> > close(6)                                = 0
> > --- SIGSEGV (Segmentation fault) ---
> > +++ killed by SIGSEGV +++
>
> The format changed, on purpose.  You need vmstat from a newer version of
> procps.  The newest version (2.0.9) and CVS dumps as-of yesterday are
> available at:
>
>        http://tech9.net/rml/procps
>
> as both tarballs and RPM packages.

2.5.40/2.5.40-mcp1 gave me same.
"top" showed only one CPU.

Solution:

Get 2.5.40-ac3. Alan "fixed" that.

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

