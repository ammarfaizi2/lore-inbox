Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBDP7H>; Sun, 4 Feb 2001 10:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129028AbRBDP66>; Sun, 4 Feb 2001 10:58:58 -0500
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:4821 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129027AbRBDP6l>; Sun, 4 Feb 2001 10:58:41 -0500
Message-ID: <3A7D7BCE.37F3DDF@wanadoo.fr>
Date: Sun, 04 Feb 2001 16:57:02 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierfrancesco Caci <p.caci@tin.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 segfault when doing "ls /dev/"
In-Reply-To: <87u26avkfp.fsf@penny.ik5pvx.ampr.org>
		<3A7D5CFB.1C21ECD2@wanadoo.fr> <87lmrmv984.fsf@penny.ik5pvx.ampr.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierfrancesco Caci wrote:

> I can't see how this can affect performance/funtionality of
> devfsd. Can you try to stop the daemon and restart it to see if
> continues to work as before ?

/dev is mounted at boot time by the kernel (CONFIG_DEVFS_MOUNT=y).
The system boots and runs without devfsd. You just can't start any 
process calling for non-existing device under /dev and not created
by devfsd. For instance pppd or mc won't start by lack of pseudo-tty 
esd needs /dev/dsp ...

i was thinking the trouble may come from some programme launched by
your boot scripts before devfsd is running.

is your version of fileutils > 4.0.28 (ls --version) ?

-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
