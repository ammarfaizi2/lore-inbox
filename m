Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277110AbRJDEMj>; Thu, 4 Oct 2001 00:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277109AbRJDEM3>; Thu, 4 Oct 2001 00:12:29 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:40166 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S277107AbRJDEMU>; Thu, 4 Oct 2001 00:12:20 -0400
Date: Thu, 4 Oct 2001 00:12:44 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: HTTP problem running v2.4 kernel (fwd)
Message-ID: <Pine.LNX.4.33.0110040012350.1175-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Oden Eriksson wrote:

> torsdagen den 4 oktober 2001 05.56 skrev Stephen Torri:
> > Has anyone noticed that certain websites that use to load reliable are no
> > longer accessible? I used to be able to get into www.nvidia.com and now it
> > doesn't load. The reason I believe this might be a kernel problem is what
> > happened when I changed on the same system to kernel 2.2.19-7.0.8smp
> > (RedHat 7.0 kernel). When I switched to that kernel the website loaded
> > with out problems. Nothing changed on the same. Same software used with
> > all the kernels I have used.
> >
> > The kernel version that I have noticed the problem:
> >
> > 2.4.10-ac4
> > 2.4.9-ac16
> >
> > Not sure if I noticed it on earlier versions. I will check again.
> >
> > How can I track down the what is really causing the problem.
>
> Check if:
>
> echo "0" > /proc/sys/net/ipv4/tcp_ecn
>
> Helps...
>
> Chears

Nasty little buggar. I had CONFIG_INET_ECN set to 1 in my config. I turned
off ECN. Thanks for the help. I will recompile the kernel so I don't have
this problem. I guess it will be a bit more for ECN enabled firewalls like
nvidia.com to get fixed.

Stephen


