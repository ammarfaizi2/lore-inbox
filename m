Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSFSVyN>; Wed, 19 Jun 2002 17:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318030AbSFSVyM>; Wed, 19 Jun 2002 17:54:12 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:64007 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318031AbSFSVyM>; Wed, 19 Jun 2002 17:54:12 -0400
Date: Wed, 19 Jun 2002 23:54:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andrew Morton <akpm@zip.com.au>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: (2.5.23) buffer layer error at buffer.c:2326
In-Reply-To: <3D10E358.D82DB604@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206192247390.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jun 2002, Andrew Morton wrote:

> Does anyone have any opinions on what the kernel's behaviour should
> be in the presence of a write I/O error?  Our options appear to be:

Another possibility would be to add a more flexible error handling
infrastructure controllable from user space. Think for example of
hotpluggable devices. Either we add support for this to all subsystems or
we add generic support at a higher level. A single daemon could ask the
user to replug the disk or temporarily save a the dirty pages to a
different device.

bye, Roman

