Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315251AbSELQmG>; Sun, 12 May 2002 12:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315252AbSELQmF>; Sun, 12 May 2002 12:42:05 -0400
Received: from unthought.net ([212.97.129.24]:32151 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S315251AbSELQmF>;
	Sun, 12 May 2002 12:42:05 -0400
Date: Sun, 12 May 2002 18:42:04 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020512184204.A17334@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Kasper Dupont <kasperd@daimi.au.dk>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CDE96F9.8443C446@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 06:23:21PM +0200, Kasper Dupont wrote:
> Usually the last 5% of the diskspace on ext2 and ext3
> filesystems are reserved for root. But I just realized
> that they can be bypassed by redirecting the output
> from a suid root program to a file.
> 
> This command will keep writing beyond the 95% limit:
> while true ; do mount ; done >filename

Hej Kasper,

Sure you were not running the shell as root ?  :)

The redirection is handled by your shell, mount doesn't have anything to do
with the '>filename' part.

Actually, the more fun test is to
  mount > /etc/passwd
or
  mount > /dev/hda

But this won't work either, unless your shell (and therefore you as a user,
suid programs or not) have the permissions as required.

In short: I don't think you are seeing what you think you are seeing  ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
