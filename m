Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbVKGUUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVKGUUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVKGUUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:20:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55058 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965198AbVKGUUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:20:53 -0500
Date: Mon, 7 Nov 2005 21:20:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Teigland <teigland@redhat.com>
Cc: linux-cluster@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/dlm/: possible cleanups
Message-ID: <20051107202051.GQ3847@stusta.de>
References: <20051104120640.GB5587@stusta.de> <20051107200431.GC20531@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107200431.GC20531@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 02:04:31PM -0600, David Teigland wrote:
> On Fri, Nov 04, 2005 at 01:06:40PM +0100, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - every file should #include the headers containing the prototypes for
> >   it's global functions
> 
> Including unnecessary headers doesn't sound right.
>...

They aren't unnecessary.

If you #include them, gcc can tell when the prototypes in the header and 
the C file are accidentially different.

Without the #include's, this would result in a nasty runtime error.

> Thanks,
> Dave

cu
Adrian

BTW: Please ignore the resending of this patch that overlapped with
     your answer.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

