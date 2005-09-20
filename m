Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVITINI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVITINI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVITINI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:13:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8625 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964926AbVITINH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:13:07 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: fawadlateef@gmail.com
Subject: Re: regarding kernel compilation
Date: Tue, 20 Sep 2005 11:12:27 +0300
User-Agent: KMail/1.8.2
Cc: Gireesh Kumar <gireesh.kumar@einfochips.com>, linux-kernel@vger.kernel.org
References: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246> <1e62d13705092000112a49cb6c@mail.gmail.com>
In-Reply-To: <1e62d13705092000112a49cb6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201112.28091.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 September 2005 10:11, Fawad Lateef wrote:
> On 9/20/05, Gireesh Kumar <gireesh.kumar@einfochips.com> wrote:
> > Hi,
> > I'd like to compile 2.4.20-6 kernel while running in 2.6 kernel. I tried
> > to do so but there are redeclaration errors with /kernel/sched.c and
> > /include/linux/sched.h. One it is FASTCALL and the other it is not.
> > Can anyone help me to fix this?

Kernel conpile should never use system includes, let alone
includes from _another_ kernel tree. (Using stdarg.h from gcc is ok)

> I don't think you will be able to compile 2.4 kernel on to the 2.6
> kernel based distro .... as in 2.6 based distro, mod-utils and other

2.6 modutils (module-init-tools to be exact) fall back to <toolname>.old
(by just exec'ing it) if those exist.

> packages are updated and will only support 2.6 based kernel .... So

Not true. I compiled 2.4 kernels on 2.6 machine without any problems.

> its better to get 2.4 kernel based distribution .... (and can keep/run
> both 2.6 and 2.4 based distributions simultanously on the same system,
> so that you can boot in any of them as per your requirement of 2.4 or
> 2.6 kernel)
--
vda
