Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265220AbSJRSgF>; Fri, 18 Oct 2002 14:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSJRSgF>; Fri, 18 Oct 2002 14:36:05 -0400
Received: from pop.gmx.de ([213.165.64.20]:36153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265220AbSJRSgE>;
	Fri, 18 Oct 2002 14:36:04 -0400
Message-ID: <3DB055D7.7080908@gmx.net>
Date: Fri, 18 Oct 2002 20:41:27 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, Tigran Aivazian <aivazian@veritas.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Forced umount
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Alexander Viro wrote:
 > > > On Sun, Sep 16, 2001, Alex Stewart wrote:
 > > > > Basically, I want a 'kill -KILL' for filesystems.
 >
 > Look at it that way: we have two actions that need to be done upon umount.
 >         1) detach it from the mountpoint(s)
 >         2) shut it down
 >
 > For the latter we need to have no active IO on that fs _and_ nothing
 > that could initiate such IO. We can separate #1 and #2, letting fs
 > shutdown happen when it's no longer busy. That's what MNT_DETACH
 > does.
 >
 > What you are asking for is different - you want fs-wide revoke().
 > That's all nice and dandy, but it's an independent problem and it
 > will take a _lot_ of work. Including work in fs drivers. It _is_
 > worth doing, but it's 2.5 stuff (along with normal revoke(2)).

Has this been done during 2.5 development or is the patch mentioned below
still the only option? And if it is the only option, what prevents it from
being included in 2.5? (I couldn't find anything about it in the archives.)
http://marc.theaimsgroup.com/?l=linux-kernel&m=103443466225915&w=4

To put it another way: Is there any chance to umount / cleanly if / is local
and /smbserver is a mounted remote SMB filesystem where the network link to
the SMB server just went down? (Without waiting half an hour for a timeout.)

Thanks for your answer

Carl-Daniel

