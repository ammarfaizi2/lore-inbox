Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271226AbRH1O6i>; Tue, 28 Aug 2001 10:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271242AbRH1O62>; Tue, 28 Aug 2001 10:58:28 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:60684 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S271226AbRH1O6P>; Tue, 28 Aug 2001 10:58:15 -0400
Message-Id: <200108281458.f7SEwSY89672@aslan.scsiguy.com>
To: Gergely Madarasz <gorgo@thunderchild.debian.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7899 problems 
In-Reply-To: Your message of "Tue, 28 Aug 2001 14:55:26 +0200."
             <20010828145526.I6202@thunderchild.ikk.sztaki.hu> 
Date: Tue, 28 Aug 2001 08:58:28 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>the error message is like this:
>
>scsi0:0:3:0: Attempting to queue an ABORT message
>scsi0:0:3:0: Cmd aborted from QINFIFO
>aic7xxx_abort returns 8194
>
>lots of these messages. the same happens on scsi0:0:4:0, scsi0:0:5:0 and
>scsi0:0:9:0, then I get ext2 and I/O errors. I have 4 of these machines
>(ibm netfinity 5100), running for several weeks now as http proxies, and
>sometimes they crash (3 from 4 have crashed so far at least once, this is
>the first time I have logs from the beginning of the crash). The kernel is
>stock 2.4.7. On another machine (netfinity 7100, aic7896) I couldn't boot
>stock 2.4.9 because I got these messages right after the boot, the old aic
>driver worked though. I'm puzzled because the 5100's worked perfectly for
>almost a month. What should I try? 

Please boot a 2.4.9 system with "aic7xxx=verbose" in your lilo.conf
(aic7xxx driver statically linked into your kernel", or:

options aic7xxx aic7xxx=`"verbose"'

in your modules.conf (you'll have to recreate the initrd for it
to take effect) if you are loading a module.  Use a serial console
to capture all messages from the start of boot through several
reported errors, and send it to me.

--
Justin
