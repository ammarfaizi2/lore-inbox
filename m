Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281392AbRKTUzS>; Tue, 20 Nov 2001 15:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281393AbRKTUzJ>; Tue, 20 Nov 2001 15:55:09 -0500
Received: from mail.deis.isec.pt ([194.65.52.68]:17338 "EHLO mail.deis.isec.pt")
	by vger.kernel.org with ESMTP id <S281392AbRKTUyw>;
	Tue, 20 Nov 2001 15:54:52 -0500
Date: Tue, 20 Nov 2001 20:54:42 +0000 (WET)
From: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
To: <linux-kernel@vger.kernel.org>
Subject: copy to user
Message-ID: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason that I need it to spend CPU time is that I'm developing a fault
injector. The purpose of a fault injection tool is, as you could imagine,
to test some critical systems and it's capacity to recover from fails. The
reason for changing the code of a process is that process must be delayed
but without leaving the CPU - everything must look like nothing wrong is
happening, except for other processes that are waiting for something from
the delayed process...

Maybe I should have explained this before... sorry.

I suppose now you can understand why SIGSTOP won't work. Hope you can help
me :)

About using udelay... this soluction seemed fine to me at first but if I
hang the CPU with udelay the scheduler will no be doing it's job (isn't
it?). This would give me even more intrusiveness (another requirement: the
less intrusiveness as possible).

Isn't there any doubt that copy_to_user can handle my problem? When I use
it to change CS, this function returns the correct number of bytes (and no
error) but, when I try to read... the old data is still there. I suppose
there is a page/segment protection against writing to CS, isn't it?

Luis Henriques

