Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266481AbSKGKhV>; Thu, 7 Nov 2002 05:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266482AbSKGKhV>; Thu, 7 Nov 2002 05:37:21 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:5897 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266481AbSKGKhU>; Thu, 7 Nov 2002 05:37:20 -0500
Message-Id: <200211071026.gA7AQEp18289@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Frank Wang" <frank@atvideo.com>, <redhat-list@redhat.com>
Subject: Re: devfs, input event system, and kernel configuration.
Date: Thu, 7 Nov 2002 13:17:57 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <002401c285e6$e32acb00$3d00000a@atvideo.com>
In-Reply-To: <002401c285e6$e32acb00$3d00000a@atvideo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 November 2002 20:50, Frank Wang wrote:
> Hi,
>
> I am trying to attach a special serial input device to an X
> application. Looking at the kernel document, it seems to me the input
> core system (the /dev/input/event#) fits the my needs nicely.  I also
> realize that the input system uses the devfs rather than the
> traditional major/minor number for its device driver.
>
> So I configured a 2.4.18-5 kernel with the following flags turned on,
>
> 	- devfs turned on,
> 	- the input core module,
> 	- the input core's keyboard and mouse modules
> 	- the input core's event modules
>
> The kernel compiles fine.  However, during boot process, everything
> under the /var/* and several device mounts were marked as read-only
> and thus the kernel fails to boot.  I tried to set the devfs=nomount
> as its boot parameter.  It didn't help either.

Sounds like filesystem corruption. Can you boot singleuser
and run fsck?
--
vda
