Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUJJKSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUJJKSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 06:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUJJKSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 06:18:32 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:32265 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268169AbUJJKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 06:18:30 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: jonathan@jonmasters.org, Jon Masters <jonmasters@gmail.com>
Subject: Re: [PATCH] make automounter runnable in foreground and add stderr logging
Date: Sun, 10 Oct 2004 13:18:22 +0300
User-Agent: KMail/1.5.4
Cc: raven@themaw.net, valdis.kletnieks@vt.edu,
       LKML <linux-kernel@vger.kernel.org>
References: <200410072049.18059.vda@port.imtp.ilyichevsk.odessa.ua> <200410092246.01429.vda@port.imtp.ilyichevsk.odessa.ua> <35fb2e590410091820c27bcd@mail.gmail.com>
In-Reply-To: <35fb2e590410091820c27bcd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410101318.22312.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 October 2004 04:20, Jon Masters wrote:
> On Sat, 9 Oct 2004 22:46:01 +0300, Denis Vlasenko 
> 
> > Can we stick to standard method of using $PATH? Please, pretty please.
> 
> That'll break some backwards compatibility - probably just go with a
> command flag to do that.

It won't break anything, because even with my patches
automount will call mount by absolute path (typically
[/usr]/bin/mount).

execvp() does not use PATH in this case.

I plan to add a flag to configure to stop using abs paths.
Only if built with this flag, automount will exec plain "mount"
and use PATH.
--
vda

