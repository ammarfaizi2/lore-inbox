Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWBIDWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWBIDWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 22:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbWBIDWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 22:22:53 -0500
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:28822 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030553AbWBIDWx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 22:22:53 -0500
Date: Wed, 8 Feb 2006 19:22:52 -0800 (PST)
From: John Schmerge <schmerge@speakeasy.net>
To: 7eggert@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Question regarding /proc/<pid>/fd and pipes
In-Reply-To: <E1F6qZR-0002uc-Kc@be1.lrz>
Message-ID: <Pine.LNX.4.58.0602081912160.25842@shell3.speakeasy.net>
References: <5DRW7-322-1@gated-at.bofh.it> <E1F6qZR-0002uc-Kc@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo,

Thanks for the answer... I've got one more question: will the symlinks
to the pipe be the same for both the read and write ends in all
processes sharing the pipe?

I've got some sort of funky race condition occurring between the read
from the pipe and the exiting of the process on the write-end of the pipe...
The read-process is supposed to exit after the write-process finishes
(and does in about 1/2 the time), but I think I'm seeing the read-process
blocked by something even after the write-process completes... Both top
and ps give no indication that the read-process is blocked on a read(2).
I've got some digging to do, but I'm thinking that this might actually be
a kernel bug.

Thanks,
John

On Wed, 8 Feb 2006, Bodo Eggert wrote:

> John Schmerge <schmerge@speakeasy.net> wrote:
>
> >   I know that the symlinks in the /proc/<pid>/fd directory point to
> > bogus filenames for pipes (i.e. 'pipe:[64682]') and am wondering if
> > every process that reads and writes from that pipe will share the same
> > bogus symlink name.
>
> yes
>
> >   In essence, I'm wondering if there's any way to list all of the pid's
> > of processes using an anonomous pipe.
>
> man find. I don't know a bettre way.
> --
> Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
> verbreiteten Lügen zu sabotieren.
>
