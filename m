Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264760AbUEYNgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbUEYNgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264761AbUEYNgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:36:20 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:43414 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S264760AbUEYNgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:36:14 -0400
Message-ID: <40B34C35.3090303@ru.mvista.com>
Date: Tue, 25 May 2004 17:37:57 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Kujau <evil@g-house.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       baptiste coudurier <baptiste.coudurier@free.fr>
Subject: Re: MORE THAN 10 IDE CONTROLLERS
References: <40B23D4A.4010708@free.fr> <40B34946.9030500@g-house.de>
In-Reply-To: <40B34946.9030500@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> baptiste coudurier schrieb:
> | Does anyone know what are major/minors for hdu, hdv, hdw, hdx ?
> 
> not being a professional, i see:
> 
> evil@sheep:~$ la /dev/hd?
> brw-rw----    1 root     disk       3,   0 2004-03-10 11:33 /dev/hda
> brw-rw----    1 root     disk       3,  64 2004-03-10 11:33 /dev/hdb
> brw-rw----    1 root     disk      22,   0 2004-03-10 11:33 /dev/hdc
> brw-rw----    1 root     disk      22,  64 2004-03-10 11:33 /dev/hdd
> brw-rw----    1 root     disk      33,   0 2004-03-10 11:40 /dev/hde
> brw-rw----    1 root     disk      33,  64 2004-03-10 11:40 /dev/hdf
> brw-rw----    1 root     disk      34,   0 2004-03-10 11:40 /dev/hdg
> brw-rw----    1 root     disk      34,  64 2004-03-10 11:40 /dev/hdh
> 
> so, it's a major number for every controller (e.g. "22" for hdc+hdd each
> belonging to one controller). hdi+hdj would be major 35, minor [0|64] ?
> i'd try this out for hdx and further...

afaik even the 2.6.x kernel defines only 10 major numbers for IDE 
devices (from 0 upto 9). All are predefined - see include/linux/major.h

> 
> did you try devfs/udev? perhaps it could solve this by itsself....?
> 
> Christian.
> 
> PS: maybe Documentation/devices.txt helps out too.
> 
> - --
> BOFH excuse #75:
> 
> There isn't any problem
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFAs0lG+A7rjkF8z0wRAmp5AJ985JGLXpxX5rSJnQM0GJNq0LkcIQCfT4hH
> kj4lr37B1urPVTAMiLbMXlE=
> =fohg
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


