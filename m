Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKBRhe>; Thu, 2 Nov 2000 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKBRhY>; Thu, 2 Nov 2000 12:37:24 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:24507 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129034AbQKBRhM>; Thu, 2 Nov 2000 12:37:12 -0500
From: Christoph Rohland <cr@sap.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com>
	<E13qiR9-0008FT-00@the-village.bc.nu>
	<20001102171717.L1876@redhat.com>
Organisation: SAP LinuxLab
Date: 02 Nov 2000 18:36:55 +0100
In-Reply-To: "Stephen C. Tweedie"'s message of "Thu, 2 Nov 2000 17:17:17 +0000"
Message-ID: <qwwu29q1djc.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, 2 Nov 2000, Stephen C. Tweedie wrote:
> The patch I sent fully implements O_SYNC (actually, it implements
> O_DSYNC, which is allowed to skip the inode sync if the only
> attribute which has changed is the timestamps) and fdatasync.  It's
> easy for me to make the DSYNC selectable via sysctl for full SU
> compliance, and I know of other unixes that already do this --- you
> really don't want existing database applications suddenly to start
> seeking to the inode block for every O_SYNC write.

No, we definitely do not want to have that. We had big performance
problems at customer sites when another unix did change the behaviour
exactly that way between releases.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
