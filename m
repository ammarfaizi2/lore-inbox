Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282223AbRKWUYX>; Fri, 23 Nov 2001 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282220AbRKWUYO>; Fri, 23 Nov 2001 15:24:14 -0500
Received: from mail1.arcor-ip.de ([145.253.2.10]:51400 "EHLO mail1.arcor-ip.de")
	by vger.kernel.org with ESMTP id <S282219AbRKWUYD>;
	Fri, 23 Nov 2001 15:24:03 -0500
Message-ID: <3BFEAF87.8040507@arcormail.de>
Date: Fri, 23 Nov 2001 21:20:23 +0100
From: Hartmut Holz <hartmut.holz@arcormail.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Input/output error
In-Reply-To: <Pine.LNX.4.33.0111221415490.1518-100000@grignard.amagerkollegiet.dk> <3BFE6E98.8090109@arcormail.de> <20011123112947.W1308@lynx.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:


> 
> I take it that this is after a normal shutdown where you are sure that
> the filesystem was unmounted cleanly?  It looks like a case where these
> files are deleted, but held open by a process.
> 


It's a normal shutdown, every filesystem is unmounted cleanly, no
complains from the os.


> Could you please try the following:
> - "telinit 1" to change into single user mode
> - make sure all of the above processes are stopped (check via ps, and
>   "/etc/rc.d/init.d/foo stop" for each one
> - "lsof | grep /var" to see if any files are still open on /var
> - umount /var
> - e2fsck -f /dev/hdX


There are a few processes running: news, something called minilgd.Even 
with these programs running lsof shows no output. If I kill these 
programs and make a normal shutdown, it loocked much better. Only a 
complain about the keyboard lock.

If I acted exactly like your advise, there is no problem with the restart.

The processes running in 2.4.15 single user mode are exactly the same as 
in 2.4.14.


Regards

Hartmut

 



