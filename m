Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130613AbRAIOyj>; Tue, 9 Jan 2001 09:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIOyU>; Tue, 9 Jan 2001 09:54:20 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:34558 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130613AbRAIOyK>; Tue, 9 Jan 2001 09:54:10 -0500
From: Christoph Rohland <cr@sap.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva>
	<20010109140932.E4284@redhat.com>
Organisation: SAP LinuxLab
Date: 09 Jan 2001 15:53:55 +0100
In-Reply-To: "Stephen C. Tweedie"'s message of "Tue, 9 Jan 2001 14:09:32 +0000"
Message-ID: <qwwhf387p4s.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> But again, how do you clear the bit?  Locking is a per-vma property,
> not per-page.  I can mmap a file twice and mlock just one of the
> mappings.  If you get a munlock(), how are you to know how many
> other locked mappings still exist?

It's worse: The issue we are talking about is SYSV IPC_LOCK. This is a
per segment thing. A user can (un)lock a segment at any time. But we
do not have the references to the vmas attached to the segemnts or to
the pages allocated.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
