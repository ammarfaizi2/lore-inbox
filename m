Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbRE3QlN>; Wed, 30 May 2001 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbRE3QlC>; Wed, 30 May 2001 12:41:02 -0400
Received: from 24.66.120.83.on.wave.home.com ([24.66.120.83]:42768 "EHLO
	trillian.adap.org") by vger.kernel.org with ESMTP
	id <S261502AbRE3Qkz>; Wed, 30 May 2001 12:40:55 -0400
Date: Wed, 30 May 2001 12:40:53 -0400
From: Edsel Adap <edsel@adap.org>
To: linux-kernel@vger.kernel.org
Subject: ln -s broken on 2.4.5
Message-ID: <20010530124052.A26266@adap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I downloaded the linux 2.4.5 sources and built and installed them on my
system.  Since then, I've noticed strange file system behavior:

marvin:~> cd /tmp
marvin:/tmp> ls -la
total 2656
drwxrwxrwt    6 root     root         1024 May 30 12:06 ./
drwxr-xr-x   22 root     root         1024 Feb 18  2000 ../
-r--r--r--    1 root     root           11 May 30 11:19 .X0-lock
drwxrwxrwt    2 root     root         1024 May 30 11:19 .X11-unix/
drwxrwxrwt    2 root     root         1024 May 30 11:18 .font-unix/
-rw-r--r--    1 adap     users     2699286 May 30 11:24 mpeg2-digital.mpg
drwx------    2 adap     root         1024 May 30 12:06 ssh-SXp13149/
drwx------    2 adap     root         1024 May 30 11:19 ssh-unNLs321/
marvin:/tmp> ln -s foo bar
marvin:/tmp> ls -la
total 2656
drwxrwxrwt    6 root     root         1024 May 30 12:06 ./
drwxr-xr-x   22 root     root         1024 Feb 18  2000 ../
-r--r--r--    1 root     root           11 May 30 11:19 .X0-lock
drwxrwxrwt    2 root     root         1024 May 30 11:19 .X11-unix/
drwxrwxrwt    2 root     root         1024 May 30 11:18 .font-unix/
lrwxrwxrwx    1 adap     users           3 May 30 12:09 bar -> bar
-rw-r--r--    1 adap     users     2699286 May 30 11:24 mpeg2-digital.mpg
drwx------    2 adap     root         1024 May 30 12:06 ssh-SXp13149/
drwx------    2 adap     root         1024 May 30 11:19 ssh-unNLs321/
marvin:/tmp>

Notice that the symlink created is wrong.  It seems that any symlink I
create is always linked to itself.

I booted 2.4.0 again, and the problem went away.  Is this a known
problem? Is there a patch?

Please cc me with your replies since I am not on the list.

-- 
Edsel Adap
edsel@adap.org
http://www.adap.org/~edsel/          LINUX - the choice of the GNU generation

"Netscape is an application which grows to fill all available memory."  - me
