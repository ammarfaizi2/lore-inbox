Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUAAJCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 04:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUAAJCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 04:02:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:29176 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265339AbUAAJCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 04:02:35 -0500
From: Juergen Hasch <lkml@elbonia.de>
To: rudi@lambda-computing.de
Subject: Re: File change notification
Date: Thu, 1 Jan 2004 10:02:48 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <3FF2FC85.5070906@lambda-computing.de>
In-Reply-To: <3FF2FC85.5070906@lambda-computing.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401011002.48223.lkml@elbonia.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:464ad01b81b0f762cd239ce6f3ab8323
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rudi,

Am Mittwoch, 31. Dezember 2003 17:42 schrieb Rüdiger Klaehn:
>
> I wrote some experimental mechanism yesterday. Whenever a file is
> accessed or changed, I write all easily available information to a ring
> buffer which is presented to user space as a device. The information
> that is easily available is the inode number of the file or directory
> that has changed, the inode number of the directory in which the change
> took place, and in most cases the name of the dentry of the file that
> has changed.

I'm also interested in receiving file change notifications, especially
as I would like to get this working for Samba in a sane way.

However I don't think your approach would help me much. I simply don't
want to get every file being changed on the whole machine getting 
reported to me.
I don't want to look up the inode every time, just to know if it belongs
to a directory I'm interested in.

Actually I *like* dnotify being local to a given directory and having
a fd so I know where the signal I receive belongs to.

So my selfish reasoning makes me want either
- dnotify being able to pass some more information if requested
  (I actually tried this and it basically works, it is just too
   crappy to post here)
or
- make poll()/epoll() work for file/directory access

So much for what I want :-)

...Juergen

