Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRGKTdj>; Wed, 11 Jul 2001 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266035AbRGKTd3>; Wed, 11 Jul 2001 15:33:29 -0400
Received: from smtp.zapmedia.com ([64.94.5.22]:41489 "EHLO
	atldcsmail04.ZAPMEDIA.COM") by vger.kernel.org with ESMTP
	id <S265586AbRGKTdU>; Wed, 11 Jul 2001 15:33:20 -0400
Message-ID: <3B4CA943.5EC6A127@zapmedia.com>
Date: Wed, 11 Jul 2001 15:30:11 -0400
From: Shawn Veader <shawn.veader@zapmedia.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: disk full or not?  you decide...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i am not a subscriber to the list but i need the help of anyone
on the list who might have some insite into this problem. please
remember to cc me on your reply. thanks!

we are using reiserfs on a system running 2.4.3 (i think i put all
of the relavant patches into the kernel before i built it then...)
we have a partition that is used when encoding ripped songs and
storing large files such as video and music. we noticed recently
that the partition reported itself as being full. after a reboot
the system reported having 6G freed. now again after a day of use
the space has dissappered. df now returns:
----
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda5             706M  229M  477M  32% /
/dev/hda2              55M   36M   19M  65% /boot
/dev/hda7             1.0G   95M  932M   9% /usr/local
/dev/hda8              26G   22G  3.7G  85% /Assets
----
however if you run du on the /Assets dir you get:
----
8.3G    /Assets
----
does anyone know why this is happening? our guess is that the logs
to reiser are getting quite large. how do we flush them and force
a garbage collection? we save and remove several large files on this
partition as the system is running. therefore, i figure that the
space is kept around till the log is flushed in case it is needed for
replaying the journal. am i totaly off?

i would like to upgrade the kernel but we have several third party
dependencies that keep us from doing that on a fast enough pace to
keep up with the 2.4.x series.

thanks again for any help that can be given. remember to cc me in
responces.

-- 
shawn veader        --oOo--      linux os developer
shawn.veader@zapmedia.com | http://www.zapmedia.com
