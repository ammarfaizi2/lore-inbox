Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316369AbSEOKkw>; Wed, 15 May 2002 06:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316371AbSEOKkv>; Wed, 15 May 2002 06:40:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26381 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316369AbSEOKkv>; Wed, 15 May 2002 06:40:51 -0400
Message-Id: <200205151036.g4FAaeY12955@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Miquel van Smoorenburg" <miquels@cistron.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: how to map "/dev/root" to "/proc/partitions" entry in user prog?
Date: Wed, 15 May 2002 13:39:15 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0205141554240.2160-100000@spaz.localdomain> <abrven$gsu$1@ncc1701.cistron.net>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2002 19:26, Miquel van Smoorenburg wrote:
> Jeff Meininger  <jeffm@boxybutgood.com> wrote:
> >How can I reliably map /dev/root to the corresponding entry in
> >/proc/partitions?
>
> The first two lines in /proc/partitions are major/minor of the
> device. Simply stat("/", &st) and use st.st_dev (and the major/minor
> macros in glibc)

Try to do it on NFS root and it will get confused.

Also it gets confused on:

# mount -o remount,ro /
mount: directory to mount not in host:dir format

Summary: /dev/root is nifty but has some rough edges.
--
vda
