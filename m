Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280932AbRKTV3D>; Tue, 20 Nov 2001 16:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280937AbRKTV2y>; Tue, 20 Nov 2001 16:28:54 -0500
Received: from otter.mbay.net ([206.40.79.2]:64263 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S280932AbRKTV2r> convert rfc822-to-8bit;
	Tue, 20 Nov 2001 16:28:47 -0500
From: John Alvord <jalvo@mbay.net>
To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: copy to user
Date: Tue, 20 Nov 2001 13:28:29 -0800
Message-ID: <amilvtcd3c2p3ttifkd6lqku169sfcpk3p@4ax.com>
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001 20:54:42 +0000 (WET), Luis Miguel Correia
Henriques <umiguel@alunos.deis.isec.pt> wrote:

>The reason that I need it to spend CPU time is that I'm developing a fault
>injector. The purpose of a fault injection tool is, as you could imagine,
>to test some critical systems and it's capacity to recover from fails. The
>reason for changing the code of a process is that process must be delayed
>but without leaving the CPU - everything must look like nothing wrong is
>happening, except for other processes that are waiting for something from
>the delayed process...
>
>Maybe I should have explained this before... sorry.
>
>I suppose now you can understand why SIGSTOP won't work. Hope you can help
>me :)
>
>About using udelay... this soluction seemed fine to me at first but if I
>hang the CPU with udelay the scheduler will no be doing it's job (isn't
>it?). This would give me even more intrusiveness (another requirement: the
>less intrusiveness as possible).
>
>Isn't there any doubt that copy_to_user can handle my problem? When I use
>it to change CS, this function returns the correct number of bytes (and no
>error) but, when I try to read... the old data is still there. I suppose
>there is a page/segment protection against writing to CS, isn't it?

Maybe the kernel logic could lock the relevent page so it couldn't be
paged out...

john alvord
