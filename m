Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbSJNCnu>; Sun, 13 Oct 2002 22:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbSJNCnu>; Sun, 13 Oct 2002 22:43:50 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:39321 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261811AbSJNCns>; Sun, 13 Oct 2002 22:43:48 -0400
Date: Sun, 13 Oct 2002 21:49:33 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg KH <greg@kroah.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
In-Reply-To: <20021014022515.GB1768@kroah.com>
Message-ID: <Pine.LNX.4.44.0210132145210.4554-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Greg KH wrote:

> +ifeq ($(CONFIG_SUMMIT),y)
> +MACHINE	= mach-summit
>  endif
>  
> Can make handle reassigning a variable?

Sure.

You could even do

	machine-y 			:= mach-generic
	machine-$(CONFIG_SUMMIT)	:= mach-summit
	...
	MACHINE				:= $(machine-y)

--Kai


