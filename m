Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290428AbSAPL5U>; Wed, 16 Jan 2002 06:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290425AbSAPL45>; Wed, 16 Jan 2002 06:56:57 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:25259
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S290424AbSAPL4t>; Wed, 16 Jan 2002 06:56:49 -0500
Subject: Re: floating point exception
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.33.0201160743010.6146-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0201160743010.6146-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 16 Jan 2002 12:55:55 +0100
Message-Id: <1011182157.513.2.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-16 at 06:45, Zwane Mwaikambo wrote:
> On 15 Jan 2002, Christian Thalinger wrote:
> 
> > Yes, it did happen that the segfault reoccured and there is nothing in
> > the dmesg. This was also my first thought, then checked
> > /var/log/messages with a tail and it stucked. No ctrl-c.
> 
> ctrl-alt-sysrq k? I'd just like to know wether your box hung completely.
> Could you also run the ver_linux script in linux_scripts so that we can
> get a better idea of your operating environment.
> 
> Cheers,
> 	Zwane Mwaikambo
> 
> 

What i got at my last exception (started the client in tty1):

Listened to an mp3 with mpg123. After the exception the mp3 got in the
_he_my_system_is_completely_locked loop. Couldn't kill the process.
System was respondable, console switching was ok. Changed to console to
tty2 where X was running - crtl-c - X went down -> console switching
wasn't possible anymore.

ctrl-alt-sysrq was responding but only with the line:

SysRq : Enmergency sync
SysRq : .... (tried also the other ones)

but nothing happend. No syncing, no unmount and showtasks. Right now i
noticed that showTasks, mem and pc do not give _any_ output, but syncing
works.

I'll do further testing when i'm back from work.

Gnu C                  3.0.3
Gnu make               3.79.1
util-linux             2.11m
mount                  2.11h
modutils               2.4.11
e2fsprogs              1.25
reiserfsprogs          3.x.0b
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Linux C++ Library      3.0.2
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         NVdriver sym53c8xx scsi_mod pwcx-i386 pwc rio500
usb-ohci
 usbcore w83781d eeprom i2c-proc i2c-amd756 i2c-isa binfmt_misc
binfmt_aout ospm
_processor ospm_system ospm_busmgr sercontrol lirc_i2c lirc_dev tuner
tvaudio ms
p3400 bttv videodev i2c-algo-bit i2c-core nfsd lockd sunrpc parport_pc
lp parpor
t via-rhine emu10k1 sound ac97_codec soundcore rtc


