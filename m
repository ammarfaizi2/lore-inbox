Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSG1NMK>; Sun, 28 Jul 2002 09:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSG1NMJ>; Sun, 28 Jul 2002 09:12:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27154 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316499AbSG1NMJ>; Sun, 28 Jul 2002 09:12:09 -0400
Message-Id: <200207281311.g6SDBVT29125@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Federico Sevilla III <jijo@free.net.ph>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: Re: Unkillable processes stuck in "D" state running forever
Date: Sun, 28 Jul 2002 16:09:33 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020728102246.GG1265@leathercollection.ph> <20020728113536.GI1265@leathercollection.ph>
In-Reply-To: <20020728113536.GI1265@leathercollection.ph>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 July 2002 09:35, Federico Sevilla III wrote:
> On Sun, Jul 28, 2002 at 06:22:46PM +0800, Federico Sevilla III wrote:
> > I have been noticing problems on two of my boxes here with some
> > processes somehow getting stuck in "D" state, which cannot be killed
> > even by a SIGKILL by root, and stay on running forever. I have noticed
> > the problem, so far, on 2.4.18-xfs and 2.4.19-rc2-xfs kernels.
>
> I do not know how small a tidbit this will be, but together with these
> processes stuck in state "D", there is a continuing rise in the load
> averages of the system as reported by various interfaces
> (top/uptime/w/phpSysInfo). On the system running 2.4.18-xfs this rose to
> up to 25 before I eventually rebooted the box.
>
> Another bit: on the 2.4.18-xfs box, the number of processes getting
> stuck in state "D" kept growing. Various `ps ax` and `sync` processes in
> particular, would get stuck and stall as I would issue them. It may be
> interesting to note that with 2.4.19-rc2-xfs, with which I had my "latest
> encounter" with this problem, no `ps ax` or `sync` processes got stuck.
> Only the couple of apt-method processes that got stuck (and any new ones
> I would launch in an attempt to download a package from the Internet for
> installation) were there.

D state processes are sitting in kernel code waiting for something
to happen. It is ok to sit in D state for milliseconds, it is acceptable
to sit for seconds. If those processes are stuck forever, it's a bug.

Capture Alt-SysRq-T output and ksymoops relevant part
Yes it means you should have ksymoops installed and tested,
which is easy to get wrong. I've done that too often.
--
vda
