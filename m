Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbRGKU01>; Wed, 11 Jul 2001 16:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRGKU0H>; Wed, 11 Jul 2001 16:26:07 -0400
Received: from ohiper1-118.apex.net ([209.250.47.133]:33936 "EHLO
	jacana.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S266707AbRGKUZ7>; Wed, 11 Jul 2001 16:25:59 -0400
Date: Wed, 11 Jul 2001 15:25:58 -0500
To: linux-kernel@vger.kernel.org
Cc: Shawn Veader <shawn.veader@zapmedia.com>
Subject: Re: disk full or not?  you decide...
Message-ID: <20010711152558.A14505@jacana.dyn.dhs.org>
In-Reply-To: <3B4CA943.5EC6A127@zapmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B4CA943.5EC6A127@zapmedia.com>; from shawn.veader@zapmedia.com on Wed, Jul 11, 2001 at 03:30:11PM -0400
From: Aaron Smith <yoda_2002@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 03:30:11PM -0400, Shawn Veader wrote:
> hello,
> i am not a subscriber to the list but i need the help of anyone
> on the list who might have some insite into this problem. please
> remember to cc me on your reply. thanks!
> 
> we are using reiserfs on a system running 2.4.3 (i think i put all
> of the relavant patches into the kernel before i built it then...)
> we have a partition that is used when encoding ripped songs and
> storing large files such as video and music. we noticed recently
> that the partition reported itself as being full. after a reboot
> the system reported having 6G freed. now again after a day of use
> the space has dissappered. df now returns:
> ----
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/hda5             706M  229M  477M  32% /
> /dev/hda2              55M   36M   19M  65% /boot
> /dev/hda7             1.0G   95M  932M   9% /usr/local
> /dev/hda8              26G   22G  3.7G  85% /Assets
> ----
> however if you run du on the /Assets dir you get:
> ----
> 8.3G    /Assets
> ----
> does anyone know why this is happening? our guess is that the logs
> to reiser are getting quite large. how do we flush them and force
> a garbage collection? we save and remove several large files on this
> partition as the system is running. therefore, i figure that the
> space is kept around till the log is flushed in case it is needed for
> replaying the journal. am i totaly off?
> 
> i would like to upgrade the kernel but we have several third party
> dependencies that keep us from doing that on a fast enough pace to
> keep up with the 2.4.x series.
> 
> thanks again for any help that can be given. remember to cc me in
> responces.
> 
> -- 
> shawn veader        --oOo--      linux os developer
> shawn.veader@zapmedia.com | http://www.zapmedia.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Try this to see if it is a large file left on the partition:  du -a | sort

I've had a problem similar to that where something spazzed out and wrote about 10 gigs to a log file.  Still haven't figured out what caused that.
-- 
-Aaron

Don't hate yourself in the morning, sleep till noon
