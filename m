Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131247AbRAPHU5>; Tue, 16 Jan 2001 02:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbRAPHUr>; Tue, 16 Jan 2001 02:20:47 -0500
Received: from [203.20.102.68] ([203.20.102.68]:20406 "HELO harper.gist.net.au")
	by vger.kernel.org with SMTP id <S131247AbRAPHUc>;
	Tue, 16 Jan 2001 02:20:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 (debian 2.2-1) with nmh-1.0.2
To: linux-kernel@vger.kernel.org
Subject: "Received disconnect: Command terminated on signal 13." when logging 
 in via ssh
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jan 2001 17:49:38 +1030
From: Allen Bolderoff <allen@gist.net.au>
Message-Id: <20010116071938.44FCE23DF1@harper.gist.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this message when logging into a box via ssh.

the box is running 2.4 Kernel with devfsd installed on debian potato.

I have a *hunch* that this may be to do with devfsd, and the fact that devfsd 
is not creating the /dev/pts/x files correctly (or in a timely manner)

to prove this, I check the /dev/pts/ (and /dev-state/pts) dirs, prior to 
logging in on another xterm, make sure that all /dev/pty/ entries are used, 
and try logging in again. same error.

Now, when I try logging in on a new pts, it shows up in /dev-state/pts/ with 
root.root ownerships, and  crw-rw-rw- permissions.

in order to log in, I have to chown it to user.tty

any ideas what is going wrong? any suggestions to fix it?

Regards

Allen


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
