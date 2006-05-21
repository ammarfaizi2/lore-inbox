Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWEUDBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWEUDBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 23:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWEUDBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 23:01:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55255 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751417AbWEUDBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 23:01:19 -0400
Date: Sun, 21 May 2006 05:00:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Andrey Savochkin <saw@sw.ru>
Subject: Re: 2.6.17-rc4-mm2
In-Reply-To: <20060520183202.73e61a1e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605210450560.17704@scrub.home>
References: <446FBB52.1080402@gmx.net> <20060520183202.73e61a1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 May 2006, Andrew Morton wrote:

> > kerncomp@p35:/sources/linux-2.6.17-rc4-mm2> make
> >   CHK     include/linux/version.h
> 
> We update the kernel version.
> 
> >   CHK     include/linux/compile.h

Actually this one is updated...

> >   CC      kernel/nsproxy.o
> >   CC      kernel/utsname.o

... and these two unnecessarily include it.
So these two patches are to blame:
namespaces-add-nsproxy.patch
namespaces-utsname-implement-utsname-namespaces.patch

bye, Roman
