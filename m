Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSJLOiz>; Sat, 12 Oct 2002 10:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSJLOiz>; Sat, 12 Oct 2002 10:38:55 -0400
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:43987 "EHLO
	nx5.HRZ.Uni-Dortmund.DE") by vger.kernel.org with ESMTP
	id <S261224AbSJLOiz>; Sat, 12 Oct 2002 10:38:55 -0400
Message-ID: <3DA8342C.40408@mathematik.uni-dortmund.de>
Date: Sat, 12 Oct 2002 16:39:40 +0200
From: Michael Abshoff <Michael.Abshoff@mathematik.uni-dortmund.de>
Reply-To: Michael.Abshoff@mathematik.uni-dortmund.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: Alan Chandler <alan@chandlerfamily.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: How does ide-scsi get loaded?
References: <5.1.0.14.0.20021012192828.0183aa08@mail.bur.st> <200210121533.12998.alan@chandlerfamily.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Chandler wrote:

>No - its not in there - as I said grep -r of /etc did not show anything
>
>>Else it may be compiled into the kernel, try passing ide-scsi=none or
>>something similar to the kernel (check the docs)
>>    
>>
>
>I do not think its in the kernel - lsmod shows ide-scsi as a loaded module.
>
>  
>
If you are using lilo to boot look for a block like the following:

  image  = /boot/vmlinuz
  label  = linux
  root   = /dev/hda7
  append = "enableapic hdd=ide-scsi"

Remove the "hdX=ide-scsi" and you are done.  In case you are using grub 
it should be a
similar layout.

Hope this helps,

Michael

-- 
Michael Abshoff - MRB - Universität Dortmund - Telefon 755-3463 (intern)



