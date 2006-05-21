Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWEUPHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWEUPHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 11:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWEUPHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 11:07:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:44456 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964884AbWEUPHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 11:07:12 -0400
Date: Sun, 21 May 2006 10:07:07 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Andrey Savochkin <saw@sw.ru>
Subject: Re: 2.6.17-rc4-mm2
Message-ID: <20060521150707.GA24683@sergelap.austin.ibm.com>
References: <446FBB52.1080402@gmx.net> <20060520183202.73e61a1e.akpm@osdl.org> <Pine.LNX.4.64.0605210450560.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605210450560.17704@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Roman Zippel (zippel@linux-m68k.org):
> Hi,
> 
> On Sat, 20 May 2006, Andrew Morton wrote:
> 
> > > kerncomp@p35:/sources/linux-2.6.17-rc4-mm2> make
> > >   CHK     include/linux/version.h
> > 
> > We update the kernel version.
> > 
> > >   CHK     include/linux/compile.h
> 
> Actually this one is updated...
> 
> > >   CC      kernel/nsproxy.o
> > >   CC      kernel/utsname.o
> 
> ... and these two unnecessarily include it.
> So these two patches are to blame:
> namespaces-add-nsproxy.patch
> namespaces-utsname-implement-utsname-namespaces.patch
> 
> bye, Roman

Argh, I see, I must have taken that out of init/version.c when
I first created kernel/utsname.c...  Sorry.

thanks,
-serge
