Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129889AbQKQQv2>; Fri, 17 Nov 2000 11:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbQKQQvT>; Fri, 17 Nov 2000 11:51:19 -0500
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:43786 "HELO
	gateway.izba.bg") by vger.kernel.org with SMTP id <S129889AbQKQQvK>;
	Fri, 17 Nov 2000 11:51:10 -0500
Date: Fri, 17 Nov 2000 18:21:16 +0200 (EET)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
To: Doug Alcorn <doug@lathi.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAQ followup: changes in open fd/proc in 2.4.x?
In-Reply-To: <m38zqitwtn.fsf@balder.seapine.com>
Message-ID: <Pine.LNX.4.10.10011171819300.4298-100000@doom.bastun.net>
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
<--cut-> 
> With the 2.2.x kernel, our choices are basically to live with the
> limitation or redesign.  We certainly don't like the limitation and
> are talking about a redesign.
> 
I have some similar problems on 2.2.xx , and i do the following:
echo 65535 >/proc/sys/fs/file-max
and then in the scripts that start the programs:
ulimit -n 65535
And everyting is fine... Even better, you can use setrlimit() to set this
in your program...( and even do the echo ... > ... there :))) )


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
