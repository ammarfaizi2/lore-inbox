Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbTALTWl>; Sun, 12 Jan 2003 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbTALTWl>; Sun, 12 Jan 2003 14:22:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40854
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267413AbTALTWj>; Sun, 12 Jan 2003 14:22:39 -0500
Subject: Re: Nervous with 2.4.21-pre3 and -pre3-ac*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ghugh Song <ghugh@mit.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030112185500.6157F475C9@bellini.mit.edu>
References: <20030112185500.6157F475C9@bellini.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042402716.16288.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 20:18:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 18:55, ghugh Song wrote:
> Many people including me are getting unusual Kernel 
> trouble recently with 2.4.21-pre3-ac*. In my case, with 
> 2.4.21-pre3-ac2 I got segmentation fault from 
> a command (tar) where I never suspected.   Yet no one seems to know 
> what part of the the kernel update caused all this 
> trouble.
> 
> Does anyone have any guess?

At the moment I am not sure. Its stable on my boxes using gcc 3.1 and
built from make distclean. At least one reporter found a patch and
build over an old built tree failed but a clean tree did not.

The obvious candidates assuming 2.4.21-pre3 is stable are the mm/shmem.c 
changes (you can back out just the diff to that file and retest which
would be interesting), or the buffer cache changes which I plan to drop
out to test soon.

Neither of these two changes are due for Marcelo.

Are you using highmem (> 900Mb RAM in the box)

Alan

