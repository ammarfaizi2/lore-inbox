Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVBGTAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVBGTAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVBGS64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:58:56 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:53108 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261234AbVBGS6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:58:25 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Fix compilation of UML after the stack-randomization patches
Date: Mon, 7 Feb 2005 18:33:13 +0100
User-Agent: KMail/1.7.2
Cc: Frank Sorenson <frank@tuxrocks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Dike <jdike@addtoit.com>
References: <4203CF43.20703@tuxrocks.com>
In-Reply-To: <4203CF43.20703@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502071833.13571.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 20:38, Frank Sorenson wrote:
> The stack randomization patches that went into 2.6.11-rc3-mm1 broke
> compilation of ARCH=um.  This patch fixes compiling by adding
> arch_align_stack back in.
>
> Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
> Acked-By: Jeff Dike <jdike@addtoit.com>

I've just spotted that if the function is arch-dependent it means that for us 
it will be subarch-dependant.

I've the doubt that the addition would better go under sys-i386 or some other 
subarch-dependent directories (in a file compiled against kernelspace 
headers, i.e. not listed in USER_OBJS in the directory it's contained 
inside), and it'd be nice to add also the x86_64 version.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


