Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267177AbSKPAyW>; Fri, 15 Nov 2002 19:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbSKPAyV>; Fri, 15 Nov 2002 19:54:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:17629 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267177AbSKPAyV> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 19:54:21 -0500
Date: Fri, 15 Nov 2002 17:00:30 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Arun Sharma <arun.sharma@intel.com>
cc: Xavier Bestel <xavier.bestel@free.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: Reserving "special" port numbers in the kernel ?
In-Reply-To: <uadkabais.fsf@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.33L2.0211151658010.6746-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2002, Arun Sharma wrote:

| xavier.bestel@free.fr (Xavier Bestel) writes:
|
| > Le sam 16/11/2002 Ã  01:00, Arun Sharma a Ã©critÂ :
| > > One of the Intel server platforms has a magic port number (623) that
| > > it uses for remote server management. However, neither the kernel nor
| > > glibc are aware of this special port.
| > >
| > > As a result, when someone requests a privileged port using
| > > bindresvport(3), they may get this port back and bad things happen.
| > >
| > > Has anyone run into this or similar problems before ? Thoughts on
| > > what's the right place to handle this issue ?
| >
| > run a dummy app at startup which reserves that port ?
|
| Yes, I'm already aware of this one, but was looking for a lighter weight
| solution (ideally a config file change) that doesn't involve running an
| extra process (think of doing this on a large number of machines).

Look in arch/i386/kernel/setup.c (in 2.4.19):

There is this array:
  struct resource standard_io_resources[] = ...
that you could add to; you could even make the addition a CONFIG_ option.

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

