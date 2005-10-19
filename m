Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVJSLIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVJSLIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVJSLIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:08:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:36513 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964791AbVJSLIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:08:18 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Keep initrd tasks running?
Date: Wed, 19 Oct 2005 14:07:26 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
References: <4355494C.5090707@comcast.net>
In-Reply-To: <4355494C.5090707@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191407.26665.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 22:13, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have no idea who's the best to ask for this.
> 
> I want to start a task in an initrd and have it stay running after init
> is started.  Pretty much:
> 
> 
>  - kernel boot
>  - initrd loaded
>  - linuxrc executes
>  - /bin/mydaemon runs
>  - mount rootfs
>  - pivot_root
>  - exec /sbin/init (PID=1; linuxrc and sh is replaced)
>  - mydaemon keeps running, reparented under init, uninterrupted
> 
> 
> What's the feasibility of this without the system balking and vomiting
> chunks everywhere?  I'm pretty sure 'exec /sbin/init' from linuxrc
> (PID=1) will replace the process image of sh (linuxrc) with init,
> keeping PID=1; but I'm worried this may terminate children too.  Haven't
> tried.

It won't terminate children. Try it manually by booting with init=/bin/sh.
--
vda
