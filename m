Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbTGDTNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266125AbTGDTNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:13:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:62678 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266113AbTGDTNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:13:39 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch 2.4.21 use propper type for pid -II
Date: Fri, 4 Jul 2003 21:28:01 +0200
User-Agent: KMail/1.5.1
References: <E19WMeK-000CqW-00@grossglockner.Informatik.Uni-Oldenburg.DE>
In-Reply-To: <E19WMeK-000CqW-00@grossglockner.Informatik.Uni-Oldenburg.DE>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307042128.02083.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Walter,

try:
alias diff='diff -u'
in .bashrc, and your diff will do, what everyone want to see here.

while at it, you may also find these useful sometimes:
alias lazydiff='diff -uiwbBd'
alias drypatch='patch --dry-run'

Aliasing-ly y'rs,
Pete

On Saturday 28 June 2003 22:50, Walter Harms wrote:
> Hi liste,
> this is a small patch to fix functions that do not use the
> correct type for pid. daniele bellucci and i have worked this
> out.
>
> walter
>
> 692c692
> < static int kill_something_info(int sig, struct siginfo *info, int
> pid) ---
>
> > static int kill_something_info(int sig, struct siginfo *info, pid_t
> > pid)
>
> 1014c1014
> < sys_kill(int pid, int sig)
> ---
>
> > sys_kill(pid_t pid, int sig)
>
> 1031c1031
> < sys_tkill(int pid, int sig)
> ---
>
> > sys_tkill(pid_t pid, int sig)
>
> 1058c1058
> < sys_rt_sigqueueinfo(int pid, int sig, siginfo_t *uinfo)
> ---
>
> > sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t *uinfo)

