Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSG2QMe>; Mon, 29 Jul 2002 12:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSG2QMe>; Mon, 29 Jul 2002 12:12:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317497AbSG2QMe>;
	Mon, 29 Jul 2002 12:12:34 -0400
Date: Mon, 29 Jul 2002 09:13:33 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Federico Sevilla III <jijo@free.net.ph>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unkillable processes stuck in "D" state running forever
In-Reply-To: <200207290819.g6T8JOT31352@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L2.0207290908110.23252-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Denis Vlasenko wrote:

| On 29 July 2002 05:22, Federico Sevilla III wrote:
| > On Sun, Jul 28, 2002 at 04:09:33PM -0200, Denis Vlasenko wrote:
| > > D state processes are sitting in kernel code waiting for something to
| > > happen. It is ok to sit in D state for milliseconds, it is acceptable
| > > to sit for seconds. If those processes are stuck forever, it's a bug.
| >
| > The processes I refer to get stuck in D state forever. I have other
| > processes that are in D state legitimately, and for reasonable amounts
| > of time depending on the task, but it is only these random processes
| > that occur once in awhile that stay there forever and drive the load
| > levels way beyond their normal levels.
| >
| > > Capture Alt-SysRq-T output and ksymoops relevant part Yes it means you
| > > should have ksymoops installed and tested, which is easy to get wrong.
| > > I've done that too often.
| >
| > It also requires access the console, right? Or is it possible to get a
| > similar task information dump when logged on remotely via SSH?
|
| It is logged by syslog. /var/log/messages if your conf is standard.
| --

That helps on the output side, sure, but I (mis?)understood the question
to be about the ability to do Alt-SysRq-x via ssh.  Is that possible?

Not that I know of, but I could be wrong about that.
So if you really need Alt-SysRq over a network connection (or even
a serial console connection)...
A few months ago I cooked up a patch so that "echo {magickey}"
mimics SysRq via proc/sysctl.  Patch against 2.4.18 is here:
  http://www.osdl.org/archive/rddunlap/patches/sys-magic.dif
Usage is:  echo {key} > /proc/sys/kernel/magickey

-- 
~Randy

