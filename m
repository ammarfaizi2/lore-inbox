Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSBGJZC>; Thu, 7 Feb 2002 04:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286925AbSBGJYs>; Thu, 7 Feb 2002 04:24:48 -0500
Received: from monza.eurecom.fr ([193.55.113.133]:39164 "HELO monza.eurecom.fr")
	by vger.kernel.org with SMTP id <S286750AbSBGJYh>;
	Thu, 7 Feb 2002 04:24:37 -0500
Message-ID: <3C62476E.5050700@eurecom.fr>
Date: Thu, 07 Feb 2002 10:22:54 +0100
From: Luis Garces <Luis.Garces@eurecom.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16YcOK-0006wT-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

 >> I ran into a somewhat related issue on a 2.2.16 system, where I
 >> had an app that was calling sendto() on 217000 packets/sec, even
 >> though the wire could only handle about 127000 packets/sec.  I
 >> got no errors at all in sendto, even though over a third of the
 >> packets were not actually being sent.
 >>
 >
 > That is correct UDP behaviour -
 >

Yes, TCP provides a reliable point-to-point path, and UDP doesn't. The 
problem is considering where does this unreliability starts in the UDP 
path. In Alan's opinion (I think) it starts in the very moment data is 
passed to the call to sendto() (i.e, includes the kernel in the 
unreliable UDP path). Perhaps it is a little sad to see the kernel as 
something lossy, but I think it's the nature of UDP.

-- 
Luis
****

