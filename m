Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290337AbSAPBh5>; Tue, 15 Jan 2002 20:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290341AbSAPBhs>; Tue, 15 Jan 2002 20:37:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:29932 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S290337AbSAPBhh>;
	Tue, 15 Jan 2002 20:37:37 -0500
Date: Tue, 15 Jan 2002 17:06:06 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, davidel@xmailserver.org, bcrl@redhat.com,
        weber@nyc.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <20020115.165207.02810582.davem@redhat.com>
Message-ID: <Pine.LNX.4.10.10201151703140.26467-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well if you look at it closely, that function.

"ide_raw_build_sglist()"

 is not called except from the user-space diagnostics ioctl

You that is getting called with from a BIO request, there will be major
request completion problems.

That is there to allow a future "Alex Viro" suggestion be considered.


On Tue, 15 Jan 2002, David S. Miller wrote:

>    From: Linus Torvalds <torvalds@transmeta.com>
>    Date: Tue, 15 Jan 2002 16:43:58 -0800 (PST)
>    
>    If it's not in the IDE driver, I'm at a loss.
> 
> That "#if 1" buisness in the new ide-dma.c code looks
> really suspicious...

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

