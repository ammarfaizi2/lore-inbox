Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUHZOoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUHZOoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUHZOoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:44:21 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:30212 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269018AbUHZOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:42:36 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 16:42:20 +0200
User-Agent: KMail/1.7
Cc: Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
References: <20040824202521.GA26705@lst.de> <m3llg2m9o0.fsf@zoo.weinigel.se> <200408261700.43253.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408261700.43253.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408261642.21643.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 16:00, Denis Vlasenko wrote:
>
> I think Hans is not planning turning old "file is a stream of bytes"
> into eight-stream octopus. One stream will remain as a 'main' one,
> which contains actual data. Others will keep metadata, etc...
>
> Note that even today's files aren't simple "streams of bytes"
> because they also have names,mode bits etc.

This is just exactly how NTFS does work: there's an unnamed stream (which is 
the one that the majority of userspace programs do manipulate) which contains 
the user data (the pixels from a PMG image, or text from a text file, etc.), 
and there are named streams which not all kind of applications do know how to 
handle.
