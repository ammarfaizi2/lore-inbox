Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTAVSmL>; Wed, 22 Jan 2003 13:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbTAVSmL>; Wed, 22 Jan 2003 13:42:11 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21262 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262452AbTAVSmJ>;
	Wed, 22 Jan 2003 13:42:09 -0500
Date: Wed, 22 Jan 2003 19:50:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brice Goglin <bgoglin@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, tigran@veritas.com, davej@suse.de,
       hpa@zytor.com, akpm@digeo.com
Subject: Re: copy_from_user broken on i386 since 2.5.57
Message-ID: <20030122185047.GA927@mars.ravnborg.org>
Mail-Followup-To: Brice Goglin <bgoglin@ens-lyon.fr>,
	linux-kernel@vger.kernel.org, tigran@veritas.com, davej@suse.de,
	hpa@zytor.com, akpm@digeo.com
References: <20030122183148.GB23109@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030122183148.GB23109@ens-lyon.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 07:31:48PM +0100, Brice Goglin wrote:
> Hi,
> 
> Trying to compile a very very simple module for 2.5,
> I got an error from gcc saying that assembly code
> is incorrect.
[snip]
> 
> Here's gcc report :
> 
> mp760:~/tmp% gcc user.c -c -o user.o -Ipath_to_2.5.57/include

Use:
make -C path/to/kernel/src SUBDIRS=$PWD modules

The way you specify is broken with recent kernels.
Btw. do not define __KERNEL__ and MODULE, thats already done,
when compiling a module like this.

	Sam
