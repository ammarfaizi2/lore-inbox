Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbSJZTHe>; Sat, 26 Oct 2002 15:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSJZTHe>; Sat, 26 Oct 2002 15:07:34 -0400
Received: from hermes.domdv.de ([193.102.202.1]:44040 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S261438AbSJZTHd>;
	Sat, 26 Oct 2002 15:07:33 -0400
Message-ID: <3DBAE931.7000409@domdv.de>
Date: Sat, 26 Oct 2002 21:12:49 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: rootfs exposure in /proc/mounts
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sat, 26 Oct 2002, Andreas Steinmetz wrote:
> 
> 
>>Maybe I do oversee the obious but:
>>
>>can somebody please explain why rootfs is exposed in /proc/mounts (I do 
>>mean the "rootfs / rootfs rw 0 0" entry) and if there is a good reason 
>>for the exposure?
> 
> 
> Mostly the fact that it _is_ mounted and special-casing its removal from
> /proc/mounts is more PITA than it's worth.
> 
Acceptable but somewhat sad as it confuses e.g. "umount -avt noproc" 
which is somewhat standard in shutdown/reboot scripts (using a softlink 
from /etc/mtab to /proc/mounts).

