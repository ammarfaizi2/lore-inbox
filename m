Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKQQo2>; Fri, 17 Nov 2000 11:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbQKQQoT>; Fri, 17 Nov 2000 11:44:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54400 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129188AbQKQQoI>; Fri, 17 Nov 2000 11:44:08 -0500
Date: Fri, 17 Nov 2000 11:13:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Doug Alcorn <doug@lathi.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: FAQ followup: changes in open fd/proc in 2.4.x?
In-Reply-To: <m38zqitwtn.fsf@balder.seapine.com>
Message-ID: <Pine.LNX.3.95.1001117110827.19105A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Nov 2000, Doug Alcorn wrote:

> I am working on a project to port a commercial app to Linux.  Our app
> is essentially a dataserver with approximately two files per database
> table.  I did a search of this mailing lists archive on the subject
> and found a discussion back in the 2.0.x days when the limit was 256.
> Basically the discussion went like this:
> 

The default is now 1024 fds (try it):

main()
{
    int fd;
    for(;;)
    {
        fd = open("/dev/null", 0);
        printf("%d\n", fd);
        if(fd < 0) exit(0);

    }
}

Something in /proc/sys/fs is supposed to increase it even more, but
I don't know how.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
