Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314040AbSDKMwL>; Thu, 11 Apr 2002 08:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314041AbSDKMwK>; Thu, 11 Apr 2002 08:52:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4626 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314040AbSDKMwK>; Thu, 11 Apr 2002 08:52:10 -0400
Message-Id: <200204111249.g3BCnnX10316@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jurgen Philippaerts <jurgen@pophost.eunet.be>,
        linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
Date: Thu, 11 Apr 2002 15:53:01 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020409212000.GK9996@sparkie.is.traumatized.org> <200204110547.g3B5l3X08802@Port.imtp.ilyichevsk.odessa.ua> <20020411103444.GA7280@sparkie.is.traumatized.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2002 08:34, Jurgen Philippaerts wrote:
> > > here's the output that i get (i'm not quite sure what to expect, so i
> > > hope this is what you need:)
> >
> > [snip]
> >
> > > Error (Oops_bfd_perror): set_section_contents Bad value
> >
> > [snip]
> >
> > I've seen the same when ksymoops was linked against old libbfd.
> > It builds without errors but could not disassemble oopsed code.
> > Check for old libbfd lying around.
>
>sorry for the long lines, but it would't be very readable otherwise
>:)

>$ locate libbfd | xargs ls -ld
>-rwxr-xr-x    1 root     root       632951 Apr 10 15:18 /usr/lib/libbfd-2.12.so
>-rw-r--r--    1 root     root       737648 Apr 10 15:18 /usr/lib/libbfd.a
>-rwxr-xr-x    1 root     root          771 Apr 10 15:18 /usr/lib/libbfd.la
>lrwxrwxrwx    1 root     root           14 Apr 10 15:24 /usr/lib/libbfd.so -> libbfd-2.12.so

>$ locate bfd.h | xargs ls -ld
>-rw-r--r--    1 root     root       134077 Apr 10 15:18 /usr/include/bfd.h

>it all looks like the new version to me

Double check that you built ksymoops against these libs, not older ones.
Even if you deleted them, you may still be using old ksymoops binary!
--
vda
