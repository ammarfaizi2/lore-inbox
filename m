Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSEHV3h>; Wed, 8 May 2002 17:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315211AbSEHV3e>; Wed, 8 May 2002 17:29:34 -0400
Received: from w007.z208177138.sjc-ca.dsl.cnc.net ([208.177.141.7]:28053 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S315214AbSEHV32>;
	Wed, 8 May 2002 17:29:28 -0400
Date: Wed, 8 May 2002 15:29:24 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: "chris@scary.beasts.org" <chris@scary.beasts.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1)
In-Reply-To: <Pine.LNX.4.33.0205082210310.17893-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.44.0205081523230.10496-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, chris@scary.beasts.org wrote:

> Are you sure about the current behaviour? Taking vsftpd as an example, it
> does
> 
1 prctl()
2 setuid()
3 setgid()
4 cap_set_proc()
 
> i.e. it only fiddles with capabilities after dropping euid == 0. Of
> course, someone is welcome to fiddle with capabilities while euid == 0.

Sure this can be done before and after the proposed patch, end results are
the same.  The difference would be what the effective caps are at step
3.5.

The point is when doing PR_SET_KEEPCAPS, one would expect not to have my
caps fiddled with at all.

Dax

