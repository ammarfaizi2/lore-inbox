Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275675AbRIZWqW>; Wed, 26 Sep 2001 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275673AbRIZWqM>; Wed, 26 Sep 2001 18:46:12 -0400
Received: from allegro.ethz.ch ([129.132.112.3]:10247 "EHLO allegro.ethz.ch")
	by vger.kernel.org with ESMTP id <S275675AbRIZWqB>;
	Wed, 26 Sep 2001 18:46:01 -0400
Date: Thu, 27 Sep 2001 00:46:17 +0200
From: Christian Jaeger <christian.jaeger@sl.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: SIGSTOP/CONT behaviour
Message-Id: <20010927004617.3ffcb95b.christian.jaeger@sl.ethz.ch>
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.8; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I just wanted to make sure I'm right about this:

If I send a SIGSTOP to another process, I can NOT rely on him not
running anymore after the kill syscall returns. Is that right? I think
so/have been told so because when the other process is in the middle of
a syscall when I send SIGSTOP it will still finish this syscall and only
afterwards stop (and my kill call will return before that).

Additionally I could imagine there isn't even a guarantee that the
process won't execute userland code anymore in the case of SMP?

(What I wanted to do is stop several file serving daemons
(ftp,samba,netatalk) from fiddling with the filesystem while I traverse
through a file tree. I need to make sure I don't get files twice because
they have been moved while traversing and so on. I would not mind that
much about file *contents* changing, though. I'd welcome other
suggestions that don't imply changing the source code of these servers.)

Thanks
Christian.
