Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317475AbSFRQWN>; Tue, 18 Jun 2002 12:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317476AbSFRQWM>; Tue, 18 Jun 2002 12:22:12 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:57264 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S317475AbSFRQWL>; Tue, 18 Jun 2002 12:22:11 -0400
Message-ID: <3D0F5DFE.5060301@antefacto.com>
Date: Tue, 18 Jun 2002 17:21:18 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shrinking ext3 directories
References: <3D0F5AFC.mailGSE111D9L@viadomus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi all :))
> 
>     All of you know that if you create a lot of files or directories
> within a directory on ext2/3 and after that you remove them, the
> blocks aren't freed (this is the reason behind the lost+found block
> preallocation). If you want to 'shrink' the directory now that it
> doesn't contain a lot of leafs, the only solution I know is creating
> a new directory, move the remaining leafs to it, remove the
> 'big-unshrinken' directory and after that renaming the new directory:
> 
>     $ mkdir new-dir
>     $ mv bigone/* new-dir/
>     $ rmdir bigone
>     $ mv new-dir bigone
>     (Well, sort of)

The zipdir component of fslint does this (while maintaining permissions
etc.).

>     Any other way of doing the same without the mess?

Not at present I think. Perhaps we'll get it for free with
the new htree directory indexing?

Padraig.

