Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSDAAh0>; Sun, 31 Mar 2002 19:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290983AbSDAAhH>; Sun, 31 Mar 2002 19:37:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5697 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290818AbSDAAg6>; Sun, 31 Mar 2002 19:36:58 -0500
Date: Mon, 1 Apr 2002 02:36:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: Linux 2.4.19-pre5
Message-ID: <20020401023641.M1331@dualathlon.random>
In-Reply-To: <20020330135333.A16794@rushmore> <3CA616B2.1F0D8A76@zip.com.au> <3CA6B210.D5AE5D7A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 10:52:00PM -0800, Andrew Morton wrote:
> False alarm.  My test app was not handling SIGBUS inside its SIGBUS
> handler. 

Good :). BTW, sigbus should never indicate an oom failure, SIGKILL is
always sent in such a case. If it would came out of a pagefault it would
mean it was a MAP_SHARED access beyond the end of the file.

thanks,

Andrea
