Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129279AbRBVNNp>; Thu, 22 Feb 2001 08:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129397AbRBVNNg>; Thu, 22 Feb 2001 08:13:36 -0500
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:42476 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id <S129279AbRBVNNQ>; Thu, 22 Feb 2001 08:13:16 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        jes@linuxcare.com
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
In-Reply-To: <94ae7g9o8t.fsf@religion.informatik.uni-bremen.de> <E14VZCs-00023R-00@the-village.bc.nu> <14996.14604.348038.42765@pizda.ninka.net>
From: Markus Germeier <mager@tzi.de>
Date: 22 Feb 2001 14:12:55 +0100
In-Reply-To: "David S. Miller"'s message of "Wed, 21 Feb 2001 13:54:20 -0800 (PST)"
Message-ID: <948zmy97zc.fsf@religion.informatik.uni-bremen.de>
User-Agent: Gnus/5.0802 (Gnus v5.8.2) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I did some further investigation and found the following:

It seems to me that this is a linux <-> solaris problem. I have no
problems with AIX 4.1.4, IRIX 6.5 or WIN2K. However all solaris boxes
I have access to (2.6, 7, 8, sparc and intel) give me a "connection
closed" after 2h, which is (at least I blelieve so ;-) the TCP timer
for keepalive.

Tell me if I can provide you with further data to nail down this bug.

Jes: I thought about your information that ssh connections do not show
this problem. I believe you are using ssh 2.3 or 2.4 from ssh.com,
right? 2.3 introduced a rekeying-feature which exchanges new keys
every 60 minutes, so the TCP keepalive is never triggered. (Due to a
bug which is still present in 2.4, we can't use these versions at my
site.)

HTH.

Regards,
        Markus

-- 
Markus Germeier
mager@tzi.de
