Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266466AbSKGKeX>; Thu, 7 Nov 2002 05:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266469AbSKGKeX>; Thu, 7 Nov 2002 05:34:23 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3849 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266466AbSKGKeW>; Thu, 7 Nov 2002 05:34:22 -0500
Message-Id: <200211071035.gA7AZnp18347@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Matt Simonsen <matt_lists@careercast.com>, linux-kernel@vger.kernel.org
Subject: Re: build kernel for server farm
Date: Thu, 7 Nov 2002 13:27:33 -0200
X-Mailer: KMail [version 1.3.2]
References: <1036620009.1332.12.camel@mattsworkstation>
In-Reply-To: <1036620009.1332.12.camel@mattsworkstation>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 November 2002 20:00, Matt Simonsen wrote:
> I am pretty familiar with the build process and kernel install for a
> single Linux box, but I wanted to confirm I'm doing things in a sane
> way for a large deployment. All the machines are the same hardware
> and running standard setups.
>
> First, I plan on compiling the kernel on a development box. From
> there my plan is basically tar /usr/src/linux, copy to each box,
> untar, copy bzImage and System.map to /boot, run make
> modules_install, edit lilo.conf, run lilo.
>
> Tips? Comments?

You can avoid kernel version/config madness if you will
arrange your farm to boot from single TFTP server and keep small
readonly root fs with /boot/*, /lib/modules/* etc
on the NFS server (TFTP and NFS servers can be the same box).

You might want to have spare boot server, just in case ;)
--
vda
