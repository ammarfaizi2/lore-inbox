Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbREVOdn>; Tue, 22 May 2001 10:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261803AbREVOde>; Tue, 22 May 2001 10:33:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4619 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261793AbREVOdU>; Tue, 22 May 2001 10:33:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Date: Tue, 22 May 2001 11:07:32 +0200
X-Mailer: KMail [version 1.2]
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, viro@math.psu.edu,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com> <01051916254708.00491@starship> <20010521101451.F555@marowsky-bree.de>
In-Reply-To: <20010521101451.F555@marowsky-bree.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <01052211073203.06233@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 May 2001 10:14, Lars Marowsky-Bree wrote:
> On 2001-05-19T16:25:47,
>
>    Daniel Phillips <phillips@bonn-fries.net> said:
> > How about:
> >
> >   # mkpart /dev/sda /dev/mypartition -o size=1024k,type=swap
> >   # ls /dev/mypartition
> >   base	size	device	type
> >   # cat /dev/mypartition/size
> >   1048576
> >   # cat /dev/mypartition/device
> >   /dev/sda
> >   # mke2fs /dev/mypartition
>
> Ek. You want to run mke2fs on a _directory_ ?

Could you be specific about what is wrong with that?  Assuming that
this device directory lives on a special purpose filesystem?

> If anything, /dev/mypartition/realdev

Then every fstab in the world has to change, not to mention adding
verbosity to interactive commands.

--
Daniel

