Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWCUV5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWCUV5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWCUV5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:57:31 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:55448 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751799AbWCUV5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:57:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XICZYkvRChJtod1UaNW0hKqbwCWiq2Gubr1yVKloDZ3YL3y2gcZgI+MAM7Rrli8eH1gQpdkCnG5OGDmO6oiiEaO3kSSH/sMR4q6a/DudCFP0hGsVnaqnbC+MyR0rsZ32KadKoGY9+Isw0VpsQcEIzVsFo8qkx72Mu8FqccdBD6M=
Message-ID: <442076BA.60000@gmail.com>
Date: Wed, 22 Mar 2006 01:57:14 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, mchehab@infradead.org
Subject: Re: DVB breaks kernel build in 2.6.16-git
References: <442067A4.3020409@garzik.org>
In-Reply-To: <442067A4.3020409@garzik.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,

Jeff Garzik wrote:
> 'make distclean && make allmodconfig && make -sj7' on x86-64 fails 
> thusly:
>
> [jgarzik@viper linux-2.6]$ make
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC [M]  drivers/media/dvb/bt8xx/bt878.o
> In file included from drivers/media/dvb/bt8xx/bt878.c:46:
> drivers/media/dvb/bt8xx/bt878.h:30:19: error: bt848.h: No such file or 
> directorydrivers/media/dvb/bt8xx/bt878.h:31:18: error: bttv.h: No such 
> file or directory
> drivers/media/dvb/bt8xx/bt878.c: In function ‘bt878_device_control’:
> drivers/media/dvb/bt8xx/bt878.c:353: warning: implicit declaration of 
> function ‘bttv_gpio_enable’
> drivers/media/dvb/bt8xx/bt878.c:359: warning: implicit declaration of 
> function ‘bttv_write_gpio’
> drivers/media/dvb/bt8xx/bt878.c:366: warning: implicit declaration of 
> function ‘bttv_read_gpio’
> drivers/media/dvb/bt8xx/bt878.c: In function ‘bt878_probe’:
> drivers/media/dvb/bt8xx/bt878.c:483: error: ‘BT848_INT_MASK’ 
> undeclared (first use in this function)
> drivers/media/dvb/bt8xx/bt878.c:483: error: (Each undeclared 
> identifier is reported only once
> drivers/media/dvb/bt8xx/bt878.c:483: error: for each function it 
> appears in.)
> make[4]: *** [drivers/media/dvb/bt8xx/bt878.o] Error 1
> make[3]: *** [drivers/media/dvb/bt8xx] Error 2
> make[2]: *** [drivers/media/dvb] Error 2
> make[1]: *** [drivers/media] Error 2
> make: *** [drivers] Error 2
>
It seems this patch got left out from the repository and hence the error.
http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=eaa86a8208da;style=gitweb


Manu

