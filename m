Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSDYS0f>; Thu, 25 Apr 2002 14:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSDYS0e>; Thu, 25 Apr 2002 14:26:34 -0400
Received: from pc132.utati.net ([216.143.22.132]:14748 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313305AbSDYS0e>; Thu, 25 Apr 2002 14:26:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: ebuddington@wesleyan.edu,
        Eric Buddington <eric@ma-northadams1b-46.bur.adelphia.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Dissociating process from bin's filesystem
Date: Thu, 25 Apr 2002 08:28:01 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020425184801.60BDC742@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 April 2002 10:47 pm, Eric Buddington wrote:
> Is there any way to dissociate a process from its on-disk binary?

Sure.  Fire up an instance of ramfs, copy the file there (and its associated 
libraries), chroot and exec the copy on ramfs.  Sort of like initrd in 
reverse. :)

You could also try to extensively rewrite the kernel to completely disable 
paging, but I wouldn't recommend it.

Rob
