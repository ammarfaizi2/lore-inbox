Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWAFPj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWAFPj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAFPj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:39:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:14488 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932402AbWAFPj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:39:57 -0500
Date: Fri, 6 Jan 2006 15:39:50 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: akpm <akpm@osdl.org>, axboe@suse.de, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bio: gcc warning fix.
Message-ID: <20060106153950.GV27946@ftp.linux.org.uk>
References: <20060106130729.31561730.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106130729.31561730.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 01:07:29PM -0200, Luiz Fernando Capitulino wrote:
> 
>  Fixes the following gcc 4.0.2 warning:
> 
> fs/bio.c: In function 'bio_alloc_bioset':
> fs/bio.c:167: warning: 'idx' may be used uninitialized in this function

NAK.  There is nothing to fix except for broken logics in gcc.
Please, do not obfuscate correct code just to make gcc to shut up.
Especially for this call of warnings; gcc4 *blows* in that area.
