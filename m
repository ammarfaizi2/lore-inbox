Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRAPQlk>; Tue, 16 Jan 2001 11:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132143AbRAPQlU>; Tue, 16 Jan 2001 11:41:20 -0500
Received: from cpe.atm0-0-0-180310.boanxx4.customer.tele.dk ([62.243.2.100]:41421
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S132113AbRAPQlL>; Tue, 16 Jan 2001 11:41:11 -0500
Message-ID: <3A6479F3.3000305@fugmann.net>
Date: Tue, 16 Jan 2001 17:42:27 +0100
From: Anders Peter Fugmann <anders.peter@fugmann.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010115
X-Accept-Language: en
MIME-Version: 1.0
To: igor.mozetic@uni-mb.si
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0+aic7xxx doesn't boot, 2.2.17 OK
In-Reply-To: <14948.13544.776999.735127@ravan.camtp.uni-mb.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw the exact same problem on my Adaptec scsi controller.

I initially solved the problem setting the data transfer rate from 
80Mb/s to 40MB/s, but I see that yours is already 40MB/s, so this is not 
an option for you.

Later I saw an announcement from Justin T. Gibbs, who, I beleive, is 
currently developing an opensource driver for Adaptec.
You can find his patches for the Adaptec aic7xxx driver, for both 2.4.0 
and 2.2.8 at: http://people.FreeBSD.org/~gibbs/linux/

The patch makes all problems go away, and all my dics on the Adaptc 
controller is now running at full speed. (Great job Gibbs.)

I hope this helps you.

Regards
Anders Fugmann

Igor Mozetic wrote:

> Intel C440GX+ with on-board Adaptec AIC-7896 fails to boot 2.4.0:
> 
> SCSI bus is being reset for host 0 channel 0
> SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
> ... ad infinitum ...
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
