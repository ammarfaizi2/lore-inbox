Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311865AbSCXTVT>; Sun, 24 Mar 2002 14:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSCXTVK>; Sun, 24 Mar 2002 14:21:10 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:52922 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S311865AbSCXTU6>; Sun, 24 Mar 2002 14:20:58 -0500
Message-Id: <200203241920.g2OJKlq00377@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
Date: Sun, 24 Mar 2002 21:20:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: andreas <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0203241757520.30437-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it hard to do some memory allocation statistics, so if some process
> at one point (as rsync did) goes crazy eating all memory, that would be
> detected?

For a good reason, systems tend to kill the process which has the
largest VM. In some cases it's a process that just went stray. In the
more common cases it would be that process that's working on
an important simulation for the last month or just your X server.

> I'm quite sure other OSes have similar funcitonality, such as AIX

AIX 3.x had this feature and IMHO it was causing too much problems.

IIRC an option to change the default bahavior came only in 4.x.


AIX also has two signals that are sent to all processes when the
swap space is full above certain thresholds, thus warning processes
about getting close to OOM condition. IIRC, a process that catches
SIGWARN is considered "well bahaved" by the system so it does not
get the SIGKILL that follows.

-- Itai
