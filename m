Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290457AbSAQUq6>; Thu, 17 Jan 2002 15:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290456AbSAQUqs>; Thu, 17 Jan 2002 15:46:48 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:60429 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S290457AbSAQUqe>; Thu, 17 Jan 2002 15:46:34 -0500
Subject: Re: hangs using opengl
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: Nick Martens <nickm@kabelfoon.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C47284A.9080607@kabelfoon.nl>
In-Reply-To: <20020117191450.932B64ADB4@drie.kotnet.org> 
	<3C47284A.9080607@kabelfoon.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 14:44:47 -0600
Message-Id: <1011300289.32057.18.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 13:38, Nick Martens wrote:
> 
> Ok thanx all Another thing when it crashes the hd load seems extremely 
> high. system config is Intel P3 1ghz, intel 815 chipset, kernel 2.4.5 
> ,xf86 4.1, kde 2.2
... 
> i also checked my logs:
> /var/log/debug contains:
...
> Jan 17 20:15:23 nick kernel: agpgart: unsupported bridge
> Jan 17 20:15:23 nick kernel: agpgart: no supported devices found.

You need a newer kernel for i815 agp support. There have been many
improvements since 2.4.5, but if it works otherwise and you're not
affected by the security issues, knock yourself out. If you don't go the
new kernel route, in your XF86Config:

Option "NvAgp" "1"

This forces Nvidia's internal AGP support. 

In os-registry.c of the NVdriver module:

NVreg_EnableAGPSBA = 0;

was a requirement for stability on my system as well. As always, YMMV.

Good luck,
Reid

