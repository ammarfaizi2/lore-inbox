Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbRGEWKz>; Thu, 5 Jul 2001 18:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264829AbRGEWKg>; Thu, 5 Jul 2001 18:10:36 -0400
Received: from pille.addcom.de ([62.96.128.34]:24590 "HELO pille.addcom.de")
	by vger.kernel.org with SMTP id <S264764AbRGEWK3>;
	Thu, 5 Jul 2001 18:10:29 -0400
Date: Fri, 6 Jul 2001 00:03:24 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Davide Libenzi <davidel@xmailserver.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
In-Reply-To: <XFMail.20010705135733.davidel@xmailserver.org>
Message-ID: <Pine.LNX.4.33.0107052357190.1054-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001, Davide Libenzi wrote:

> This patch add a new linux/macros.h that is supposed to host utility macros
> that otherwise developers are forced to define in their files.
> This version contain only min(), max() and abs().

It's a good old tradition to put macros in uppercase letters. This would 
have avoided one fatal error in your patch, the conflict with the gcc 
built-in 
	
	int abs(int);

which has it's prototype in include/linux/kernel.h. There's places which 
depend on this and would break with your macro.

Also, unless you have more macros in mind, it may make sense to just place 
MIN, MAX in kernel.h and of course to remove similar macro definitions 
throughout the kernel and replace them by the commonly defined ones.

--Kai

