Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268974AbRHLHg2>; Sun, 12 Aug 2001 03:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268977AbRHLHgT>; Sun, 12 Aug 2001 03:36:19 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9234 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268974AbRHLHgC>;
	Sun, 12 Aug 2001 03:36:02 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: louisg00@bellsouth.net
cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: Unknown error 
In-Reply-To: Your message of "Sun, 12 Aug 2001 01:40:01 -0400."
             <20010812054001.VTIR4421.imf12bis.bellsouth.net@[127.0.0.1]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 17:36:07 +1000
Message-ID: <10497.997601767@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001 1:40:01 -0400, 
<louisg00@bellsouth.net> wrote:
>I'm running kernel-2.4.8-ac1 on RH beta and I'm this:
>
>modprobe: modprobe: Can't locate module char-major-226
>Did I forget a to compile a module?

2.4.8 says that device 228 is unassigned, but ...

  drivers/char/drm/drm.h:#define DRM_MAJOR       226
  drivers/net/wan/sdla_chdlc.c:#define WAN_TTY_MAJOR 226

Somebody has been naughty and used a code not assigned to them.

