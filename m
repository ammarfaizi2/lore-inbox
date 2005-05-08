Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVEHNTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVEHNTs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbVEHNTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:19:48 -0400
Received: from CPE-143-238-244-123.nsw.bigpond.net.au ([143.238.244.123]:55795
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262863AbVEHNTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:19:45 -0400
Message-ID: <427E11B1.3060005@eyal.emu.id.au>
Date: Sun, 08 May 2005 23:18:41 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.com>
Subject: Re: [PATCH] Really *do* nothing in while loop [OT - style]
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
In-Reply-To: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Glanzmann wrote:
> [PATCH] Really *do* nothing in while loop
> 
> Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
> 
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -335,7 +335,7 @@
>  	stream.next_in = hdr;
>  	stream.avail_in = hdrlen;
>  	while (deflate(&stream, 0) == Z_OK)
> -		/* nothing */
> +		/* nothing */;

I am explicitly ignoring the core subject on this thread. This
is a side note, regarding coding style.

I always use a common format for an empty body:

	while (deflate(&stream, 0) == Z_OK)
		{}

It stands out and positively says what is meant. As such it
makes it much more readable.

I think that CodingStyle should provide guidance for empty
bodies.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
