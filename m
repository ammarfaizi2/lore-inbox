Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280192AbRKEEeQ>; Sun, 4 Nov 2001 23:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280199AbRKEEeF>; Sun, 4 Nov 2001 23:34:05 -0500
Received: from mnh-1-08.mv.com ([207.22.10.40]:41742 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S280192AbRKEEd6>;
	Sun, 4 Nov 2001 23:33:58 -0500
Message-Id: <200111050552.AAA06451@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification 
In-Reply-To: Your message of "Sun, 04 Nov 2001 19:13:15 PST."
             <E160aCK-0001Fs-00@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Nov 2001 00:52:51 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bodnar42@phalynx.dhs.org said:
> >  Mounting it synchronous will  disable caching in the VM.  
> Who told
> you that? Synchronous mounting turns off write buffering. Even with
> "-o sync" writes will still end up in the page cache, they'll just be
> commited immediately.

Ummm, how about O_DIRECT instead of O_SYNC (or maybe as well, my googling
hasn't been clear on whether O_DIRECT bypasses the cache on writes as well)?

All IO bypasses the virtual machine cache, so there's no multiple caching.

> Er, it will be shared in the host's context, but each VM will still
> have  their own copy in the page cache. This is no better than a
> COW'ed block device 

Nope.  You O_DIRECT here as well.

				Jeff

