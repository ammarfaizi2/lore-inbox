Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWEXVbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWEXVbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 17:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWEXVbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 17:31:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:25234 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932494AbWEXVbk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 17:31:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AGFBRO0fChaqve2jNoDp/Vn0BpITCRKwGI+uVbWHVxP5J1zlChtTJ7LEgSRmq2TqZ/B6snM2ksC7ThNPpviOref7VKir+cNkxinfPTqY0O2P6pzK3aznd+c5p1M/a3BT0rMGsGMwTSZx7NVCnM6MPukbd5n35XJ6Y6NQieJNVjI=
Message-ID: <6bffcb0e0605241431i2bf5e8cds526728fd3fd37ca3@mail.gmail.com>
Date: Wed, 24 May 2006 23:31:39 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ben Greear" <greearb@candelatech.com>
Subject: Re: Issue with make -j4 when building in separate tree.
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4474C6F2.1010304@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4474C6F2.1010304@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On 24/05/06, Ben Greear <greearb@candelatech.com> wrote:
> There seems to be a dependency problem when running
> make with multiple jobs (-j4).
>
> I am compiling 2.6.16.16 in a separate tree.  I created
> the tree with the command:
>
> [greear@xeon-dt linux-2.6.dev]$ make O=~/kernel/2.6/linux-2.6.16.k6/ xconfig
>
> Then tried to build with this command.
>
> [greear@xeon-dt linux-2.6.16.k6]$ make -j4 bzImage modules
> make -C /home/greear/git/linux-2.6.dev O=/home/greear/kernel/2.6/linux-2.6.16.k6 bzImage
> make -C /home/greear/git/linux-2.6.dev O=/home/greear/kernel/2.6/linux-2.6.16.k6 modules
>    GEN    /home/greear/kernel/2.6/linux-2.6.16.k6/Makefile
>    GEN    /home/greear/kernel/2.6/linux-2.6.16.k6/Makefile
>    CHK     include/linux/version.h
>    CHK     include/linux/version.h
>    UPD     include/linux/version.h
>    UPD     include/linux/version.h
> mv: cannot stat `include/linux/version.h.tmp': No such file or directory
> make[2]: *** [include/linux/version.h] Error 1
> make[1]: *** [bzImage] Error 2
> make: *** [bzImage] Error 2
> make: *** Waiting for unfinished jobs....
>    SYMLINK include/asm -> include/asm-i386
>
>
> This error has existed at least since 2.6.13.
>
> Thanks,
> Ben

Please try
make -j4 O=~/kernel/2.6/linux-2.6.16.k6/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
