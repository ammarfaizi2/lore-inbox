Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSILShH>; Thu, 12 Sep 2002 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSILShH>; Thu, 12 Sep 2002 14:37:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54797 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316935AbSILShG>; Thu, 12 Sep 2002 14:37:06 -0400
Message-Id: <200209121837.g8CIbIp06737@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@digeo.com>, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
Date: Thu, 12 Sep 2002 21:32:26 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3D7FFF12.24B0FDAA@digeo.com> <200209120640.g8C6eTD00198@eng4.beaverton.ibm.com> <3D804036.4C000672@digeo.com>
In-Reply-To: <3D804036.4C000672@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2002 05:20, Andrew Morton wrote:
> > Lastly, a bit of a philosophical question.  /proc/stat and (with this
> > patch) /proc/diskstats provide some of the same information. Should
> >
> >     a) all of it appear in /proc/stat?
> >
> >     b) all of it appear in /proc/diskstats?
> >
> >     c) keep the current (limited) info in /proc/stat (for backward
> >        compatibility) and introduce the expanded info in
> >        /proc/diskstats?
> >
> > My preference is b, but I'm open to other opinions.
>
> b).  Let's get the kernel right and change userspace to follow.  We have
> another accounting patch which breaks top(1), so Rik has fixed it (and
> is feeding the fixes upstream).

Erm... Some of /proc/stat data has no relations to disks, namely CPU counts.
It would be strange to have CPU stats in /proc/diskstats...
--
vda
