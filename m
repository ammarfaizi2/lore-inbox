Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315526AbSEHF3E>; Wed, 8 May 2002 01:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSEHF3D>; Wed, 8 May 2002 01:29:03 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44553 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315526AbSEHF3C>; Wed, 8 May 2002 01:29:02 -0400
Message-Id: <200205080525.g485PjX21973@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: _reliable_ way to get the dev for a mount point?
Date: Wed, 8 May 2002 08:28:43 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0205051830060.28842-100000@balu> <20020506173857.GA24013@codepoet.org> <1020708630.17586.41.camel@bip>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > stat(mnt_point, &statbuf); then walk through /dev and stat each
> > device, check that it is a block device and that st_rdev matches
> > the statbuf.st_rdev.  When you get a match, you know a device
> > name for the directory.
>
> is devfs walkable ? I mean, no loops or infinite dynamically generated
> directory ?

If not, you still can do that but walk method must be clever
(do 1-level deep search, then 2-level, etc)
--
vda
