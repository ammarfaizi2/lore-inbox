Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279786AbRJ0HAD>; Sat, 27 Oct 2001 03:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279788AbRJ0G7v>; Sat, 27 Oct 2001 02:59:51 -0400
Received: from pasuuna.fmi.fi ([193.166.211.17]:50445 "EHLO pasuuna.fmi.fi")
	by vger.kernel.org with ESMTP id <S279786AbRJ0G7l>;
	Sat, 27 Oct 2001 02:59:41 -0400
From: Kari Hurtta <hurtta@leija.mh.fmi.fi>
Message-Id: <200110270700.f9R70AkT028190@leija.fmi.fi>
Subject: [off topic?] Re: [PATCH] strtok --> strsep in framebuffer drivers (part
 2)
In-Reply-To: <3BD8154E.24511282@loewe-komp.de>
To: =?ISO-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>
Date: Sat, 27 Oct 2001 10:00:10 +0300 (EEST)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL95a (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Filter: pasuuna: 2 received headers rewritten with id 20011027/08605/01
X-Filter: pasuuna: ID 3994, 1 parts scanned for known viruses
X-Filter: leija.fmi.fi: ID 23368, 1 parts scanned for known viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> René Scharfe wrote:

> NAME
>        strsep - extract token from string
> [...]
> RETURN VALUE
>        The strsep() function returns a pointer to the  token,  or
>        NULL if delim is not found in stringp.
> 
> If strsep returns NULL, and you dereference it -> Oops.
> 
> 
> ! if (!this_opt)
> 	continue;

Is that manual page incorrect?

I would think that 

	strsep() returns NULL  when *stringp points to '\0' character
	
	and that if delim is not found in stringp then stringp
	is just advanced to '\0' character of string (and original
	*stringp value is returned)

If that is not true, then these all patches are incorrect.
Namely last token will be skipped.

-- 
          /"\                           |  Kari 
          \ /     ASCII Ribbon Campaign |    Hurtta
           X      Against HTML Mail     |
          / \                           |
