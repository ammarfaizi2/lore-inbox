Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281669AbRKZNYr>; Mon, 26 Nov 2001 08:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281664AbRKZNYh>; Mon, 26 Nov 2001 08:24:37 -0500
Received: from ns.suse.de ([213.95.15.193]:31748 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281663AbRKZNY1>;
	Mon, 26 Nov 2001 08:24:27 -0500
Date: Mon, 26 Nov 2001 14:24:25 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] net/802/Makefile
Message-ID: <20011126142425.B27554@suse.de>
In-Reply-To: <20011126140645.B3014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011126140645.B3014@suse.de>; from olh@suse.de on Mon, Nov 26, 2001 at 02:06:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, Olaf Hering wrote:

> Hi,
> 
> the build stops when cl2llc.c has no write permissions.

Here is a better version, suggested by Rik:

diff -urN linuxppc_2_4/net/802/Makefile.broken
linuxppc_2_4/net/802/Makefile
--- linuxppc_2_4/net/802/Makefile.broken        Mon Nov 26 13:28:56 2001
+++ linuxppc_2_4/net/802/Makefile       Mon Nov 26 14:22:55 2001
@@ -57,4 +57,6 @@
 include $(TOPDIR)/Rules.make
 
 cl2llc.c: cl2llc.pre
+       touch cl2llc.c
+       chmod u+w cl2llc.c
        sed -f ./pseudo/opcd2num.sed cl2llc.pre >cl2llc.c



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
