Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWG3MIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWG3MIW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWG3MIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:08:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9446 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932296AbWG3MIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:08:22 -0400
Subject: Re: [PATCH 00/23] V4L/DVB fixes
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       akpm@osdl.org, Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
References: <20060725180311.PS54604900000@infradead.org>
	 <1154222716.27019.39.camel@praia>
	 <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 30 Jul 2006 09:07:35 -0300
Message-Id: <1154261256.27019.55.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Em Sáb, 2006-07-29 às 23:02 -0700, Linus Torvalds escreveu:
> 
> On Sat, 29 Jul 2006, Mauro Carvalho Chehab wrote:
> > 
> > Please pull these (and the other ones) from master branch at:
                                                ++++++
> >         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
> 
> I get a _huge_ diffstat with
> 
>  135 files changed, 3056 insertions(+), 1562 deletions(-)
I suspect you tried to pull from branch "devel". Branch "master" seems
ok to me.


$ git cherry -v origin
+ 061b623c54c5722fbb55fddbbdacbf97e8a82701 V4L/DVB (4291): Add dvbpll
i2c device check.
+ 04c56d0e5b27f1f65e4d20b46731d55341d42a6a V4L/DVB (4292): Fix DISEQC
regression
+ f2813093810276a2a3c1f116f23baf2ab7a669bd V4L/DVB (4293): Fix unstable
DISEQC behaviour on budget cards.
+ 93e2b1ae97dedd66ca0cb8ac1a5ceb4904631091 V4L/DVB (4294): Fix broken
tda665x PLL definition.
+ 6a85774741f1ef1a47ba0670e99c97e892930cad V4L/DVB (4295): Fix typo in
comment for TDA9819
+ 6ba475042f0ca54bf055ce94b2a1e4656ed143f9 V4L/DVB (4296): Remove
stradis MODULE_DEVICE_INFO definition
+ c526e224e4075eff788a992f59bc4a9006b12923 V4L/DVB (4298): Check all
__must_check warnings in bttv.
+ d5fdd1354e04658ea25150cc152a395bb6ecb6da V4L/DVB (4306): Support non
interlaced capture by default for saa713x
+ 7845701820c420454bcfdc4902fad68901d9ff83 V4L/DVB (4310): Saa7134:
rename dmasound_{init, exit}
+ a62c61d3820417e8efac8796f0a46d7ab337af8d V4L/DVB (4313): Bugfix for
keycode calculation on NPG remotes
+ d9cd2d9b61898354f5dbabdc490dd6ef309ebbd4 V4L/DVB (4314): Set the
Auxiliary Byte when tuning LG H06xF in analog mode
+ 3117beec7e43f91ce156cacf033a712c7e22737d V4L/DVB (4316): Check
__must_check warnings
+ 32e4c3a5622e832938aa0272e21a292564ff090a V4L/DVB (4323):
[budget/budget-av/budget-ci/budget-patch drivers] fixed DMA start/stop
code
+ e61b6fc58b4a0b07f1ccfc67bf2b84a2848fcb2c V4L/DVB (4337): Refine dead
code elimination in pvrusb2
+ 55c05b6d226f68266d1f88dd81795b04d096b1c8 V4L/DVB (4311): Fix possible
dvb-pll oops
+ 95faba22d8b81f0cd85b995232b7d05c45a26f3e V4L/DVB (4322): Fix dvb-pll
autoprobing
+ eb4eeccc18246c852fffc771efc3c07a547aeb97 V4L/DVB (4341):
VIDIOCSMICROCODE were missing on compat_ioctl32
+ f251d23eaee673524171b24a71a8794acf82783e V4L/DVB (4342): Fix
ext_controls align on 64 bit architectures
+ 985bc96e27c729b8b686126ed26bba9fbaaf562d V4L/DVB (4343): Fix for
compilation without V4L1 or V4L1_COMPAT
+ fb0b664c22b80df62c9e555afcde6a8dab08f4f0 V4L/DVB (4344): Fix broken
dependencies on media Kconfig
+ df2732706c745c827762aaf51892f281fb937680 V4L/DVB (4365): OVERLAY flag
were enabled by mistake
+ 53dd8def52100ed8be4dae0cf1c2dc1f7e0fcd2c V4L/DVB (4367): Videodev:
Handle class_device related errors
+ d94fc9a08e51432d0d5fc0f74a4f705d7b49c251 V4L/DVB (4368): Bttv: use
class_device_create_file and handle errors
+ 08d41808362a3663c0856c9720ad940a61156fb5 V4L/DVB (4373): Correctly
handle sysfs error leg file removal in pvrusb2
+ 8c313111a2c843610f58d57b4e02159fecef4bbf V4L/DVB (4379): Videodev:
Check return value of class_device_register() correctly
+ ddecbe112b057c333a8e055fb417451a02b9df78 V4L/DVB (4380): Bttv: Revert
VBI_OFFSET to previous value, it works better

$ git-diff origin|diffstat
 drivers/media/dvb/dvb-core/dvb_frontend.c    |   15 ++--
 drivers/media/dvb/frontends/dvb-pll.c        |   24 ++++++-
 drivers/media/dvb/ttpci/av7110.c             |    4 -
 drivers/media/dvb/ttpci/av7110_v4l.c         |   12 +--
 drivers/media/dvb/ttpci/budget-av.c          |    3
 drivers/media/dvb/ttpci/budget-ci.c          |    2
 drivers/media/dvb/ttpci/budget-core.c        |   57 +++++++++++++-----
 drivers/media/dvb/ttpci/budget-patch.c       |    2
 drivers/media/dvb/ttpci/budget.c             |    5 -
 drivers/media/dvb/ttpci/budget.h             |    7 +-
 drivers/media/video/Kconfig                  |    4 -
 drivers/media/video/bt8xx/Kconfig            |    2
 drivers/media/video/bt8xx/bttv-driver.c      |   15 ++++
 drivers/media/video/bt8xx/bttv-vbi.c         |   15 +++-
 drivers/media/video/compat_ioctl32.c         |   24 +++++++
 drivers/media/video/cpia2/Kconfig            |    2
 drivers/media/video/cx88/cx88-input.c        |    2
 drivers/media/video/cx88/cx88-video.c        |    5 -
 drivers/media/video/msp3400-driver.c         |   10 ++-
 drivers/media/video/pvrusb2/pvrusb2-hdw.c    |    8 +-
 drivers/media/video/pvrusb2/pvrusb2-io.c     |    9 +-
 drivers/media/video/pvrusb2/pvrusb2-io.h     |    2
 drivers/media/video/pvrusb2/pvrusb2-ioread.c |    5 -
 drivers/media/video/pvrusb2/pvrusb2-sysfs.c  |   85
+++++++++++++++++++++++----
 drivers/media/video/saa7134/saa7134-alsa.c   |   10 +--
 drivers/media/video/saa7134/saa7134-core.c   |   16 ++---
 drivers/media/video/saa7134/saa7134-oss.c    |   10 +--
 drivers/media/video/saa7134/saa7134-video.c  |    6 -
 drivers/media/video/saa7134/saa7134.h        |    4 -
 drivers/media/video/stradis.c                |    1
 drivers/media/video/tuner-core.c             |   31 +++------
 drivers/media/video/tuner-simple.c           |   19 +++++-
 drivers/media/video/usbvideo/Kconfig         |    8 +-
 drivers/media/video/v4l2-common.c            |   24 ++++---
 drivers/media/video/videodev.c               |   29 +++++++--
 drivers/media/video/vivi.c                   |    4 -
 include/linux/videodev.h                     |    7 +-
 include/linux/videodev2.h                    |    2
 include/media/v4l2-dev.h                     |    7 +-
 39 files changed, 354 insertions(+), 143 deletions(-)

Cheers, 
Mauro.

