Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290153AbSAWWQS>; Wed, 23 Jan 2002 17:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290155AbSAWWQI>; Wed, 23 Jan 2002 17:16:08 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:17162 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S290153AbSAWWPt>; Wed, 23 Jan 2002 17:15:49 -0500
To: vic <zandy@cs.wisc.edu>
Cc: Mike Coleman <mkc@mathdogs.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com> <m3advcq5jv.fsf@localhost.localdomain>
	<878zawvl1v.fsf@devron.myhome.or.jp>
	<m3sn8xkkyn.fsf@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 24 Jan 2002 07:14:17 +0900
In-Reply-To: <m3sn8xkkyn.fsf@localhost.localdomain>
Message-ID: <87r8ogr9za.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vic <zandy@cs.wisc.edu> writes:

> Now I see the problem with PTRACE_KILL.  Thanks for the example.
> 
> I'm looking into it.  I need to justify the quoted portion of the
> patch or find a better way to get its effect.
> 
> In the meantime, the problem could be fixed by changing the
> PTRACE_KILL implementation to call send_sig instead of setting
> exit_code.  How does that strike people?

PTRACE_SYSCALL, PTRACE_CONT, and PTRACE_SINGLESTEP can't send a signal
by the same reason. Please read the do_signal().
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
