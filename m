Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273117AbRIJAzv>; Sun, 9 Sep 2001 20:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273120AbRIJAzm>; Sun, 9 Sep 2001 20:55:42 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:41996 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273117AbRIJAze>; Sun, 9 Sep 2001 20:55:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "SATHISH.J" <sathish.j@tatainfotech.com>,
        Brian Gerst <bgerst@didntduck.org>
Subject: Re: Reg lilo.conf changed and system doesn't boot
Date: Mon, 10 Sep 2001 03:02:53 +0200
X-Mailer: KMail [version 1.3.1]
Cc: kernelnewbies <kernelnewbies@nl.linux.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10109091043110.4648-100000@blrmail>
In-Reply-To: <Pine.LNX.4.10.10109091043110.4648-100000@blrmail>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910005547Z16149-26184+196@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 9, 2001 07:14 am, SATHISH.J wrote:
> Hi,
> Thanks fot the suggestion.
> I tried that but it panics. Will I be able to change anything inside the
> boot floppy after it has been made with 2.2.6 kernel so that I can boot
> 2.2.14. 

Usually the easiest thing to do is boot from any install CD and hit
Ctrl-Alt-F1, which will give you a command prompt.  Then you can mount your
hard disk, edit /etc/lilo.conf and run lilo, something like this:

  mkdir /a                 # a convenient mount point on the CD's ramdisk
  mount /dev/hda? /a       # Change "?" to the number of your root partition
  ls /a                    # you should see bin, usr, etc.
  mcedit /a/etc/lilo.conf  # fix your configuration
  lilo -r /a               # rerun lilo, chrooting to your disk first
                           # take out the CD and reboot

Caveat: I've never tried this myself.  Take a look at the lilo docs to see
some examples of how your lilo.conf should look.

If you need further help you should consider joining an irc channel, for
example, irc.openprojects.net #linpeople

Linux kernel mailing list isn't the right place to ask this kind of
question.

--
Daniel

> On Fri, 7 Sep 2001, Brian Gerst wrote:
> 
> > "SATHISH.J" wrote:
> > > 
> > > Hi,
> > > I know that this is not the place to ask this question.Please forgive me.
> > > I changed the lilo.conf on my machine(redhat 2.2.14-12 kernel) and it
> > > doesn't boot up. I don't have
> > > a boot floppy to boot. I have another disk which has an older version of
> > > linux(2.2.6). I can mount the disk if I boot from the other
> > > disk(2.2.6). Can I
> > > in some way alter the lilo.conf of my disk(2.2.14) and boot linux from
> > > that. Please tell me any ideas to do that.
> > 
> > Boot your 2.2.6 disk, and make a boot floppy from that.  Put in the
> > original disk and boot from the floppy.  Check your lilo.conf and rerun
> > lilo.
