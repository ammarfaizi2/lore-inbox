Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278986AbRJ2E1x>; Sun, 28 Oct 2001 23:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278984AbRJ2E1n>; Sun, 28 Oct 2001 23:27:43 -0500
Received: from zok.SGI.COM ([204.94.215.101]:61903 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278985AbRJ2E1Z>;
	Sun, 28 Oct 2001 23:27:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Taral <taral@taral.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/net/ip_conntrack problems 
In-Reply-To: Your message of "Sun, 28 Oct 2001 22:08:54 MDT."
             <20011028220854.A17685@taral.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Oct 2001 15:27:52 +1100
Message-ID: <3974.1004329672@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2001 22:08:54 -0600, 
Taral <taral@taral.net> wrote:
>% dd if=/proc/net/ip_conntrack bs=128 | wc -l
>0+0 records in
>0+0 records out
>      0
>% dd if=/proc/net/ip_conntrack bs=256 | wc -l
>0+3 records in
>0+3 records out
>      3
>Can anyone explain this? (2.4.13-ac3) It's wreaking havoc with my
>program.

Some /proc output is blocked, it will only return complete lines.  If
your buffer is not big enough to hold the next line then you don't get
anything at all.  Try cat /proc/net/ip_conntrack | wc.

