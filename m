Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313401AbSDLEwx>; Fri, 12 Apr 2002 00:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313402AbSDLEww>; Fri, 12 Apr 2002 00:52:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:21696 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313401AbSDLEwv>;
	Fri, 12 Apr 2002 00:52:51 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15542.26636.857088.97277@argo.ozlabs.ibm.com>
Date: Fri, 12 Apr 2002 14:52:28 +1000 (EST)
To: Rik van Riel <riel@conectiva.com.br>
Cc: Tom Rini <trini@kernel.crashing.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove compiler.h from mmap.c
In-Reply-To: <Pine.LNX.4.44L.0204111457100.31387-100000@duckman.distro.conectiva>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:

> Absolutely agreed, but likely/unlikely is such low-level
> stuff that it shouldn't be included directly into .c files,
> IMHO.

mm/mmap.c uses unlikely (line 570).  Therefore it should include
compiler.h itself IMHO, not rely on some other header to include it.
I think that each .c and .h file should include the headers that
define the things it uses, but should not have to include headers just
to define things that subsequent headers use.

Regards,
Paul.
