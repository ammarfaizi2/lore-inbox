Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWHHVXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWHHVXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWHHVXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:23:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:22439 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030285AbWHHVXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:23:13 -0400
Date: Tue, 8 Aug 2006 14:22:44 -0700
From: Greg KH <greg@kroah.com>
To: mchehab@infradead.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 00/14] V4L/DVB updates
Message-ID: <20060808212244.GA18650@kroah.com>
References: <20060808210151.PS78629800000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808210151.PS78629800000@infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 06:01:51PM -0300, mchehab@infradead.org wrote:
> ---
> 
>  drivers/media/dvb/bt8xx/dst.c                      |   58 -
>  drivers/media/dvb/dvb-core/Makefile                |    6 
>  drivers/media/radio/Kconfig                        |   12 
>  drivers/media/radio/Makefile                       |    1 
>  drivers/media/radio/dsbr100.c                      |  430 +++++++++++++
>  drivers/media/video/Kconfig                        |   12 
>  drivers/media/video/Makefile                       |    2 
>  drivers/media/video/compat_ioctl32.c               |   32 
>  drivers/media/video/cx25840/cx25840-core.c         |    4 
>  drivers/media/video/cx88/cx88-video.c              |    4 
>  drivers/media/video/dsbr100.c                      |  430 -------------
>  drivers/media/video/msp3400-kthreads.c             |    4 
>  drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c |    2 
>  driverg/media/video/pwc/Kconfig                    |    2 
>  drivers/media/video/pwc/pwc-if.c                   |    1 
>  drivers/media/video/saa7134/saa7134-video.c        |    2 
>  drivers/media/video/tuner-types.c                  |   14 
>  drivers/media/video/v4l1-compat.c                  |    4 
>  drivers/media/video/v4l2-common.c                  |    6 
>  drivers/media/video/videodev.c                     |    2 
>  drivers/media/video/vivi.c                         |    4 
>  include/media/v4l2-dev.h                           |    2 
>  sound/oss/Kconfig                                  |    6 
>  sound/pci/Kconfig                                  |   70 +-
>  24 files changed, 569 insertions(+), 541 deletions(-)

In the future (I know Linus has asked me to do this, and it makes
sense), can you generate the diffstat with:
	git diff -M --stat --summary
so that it shows the renames instead?  That way when I (or Linus) pulls,
it shows the same thing to me, that you show here.  As an example, when
I pulled this I got the following:

Merge ad552692a4489917fa4b71f9c6a91baae4aee799, made by recursive.
 drivers/media/dvb/bt8xx/dst.c               |   58 ++++++++++------------
 drivers/media/dvb/dvb-core/Makefile         |    6 +-
 drivers/media/radio/Kconfig                 |   12 ++++-
 drivers/media/radio/Makefile                |    1 
 drivers/media/{video => radio}/dsbr100.c    |    0 
 drivers/media/video/Kconfig                 |   12 -----
 drivers/media/video/Makefile                |    2 -
 drivers/media/video/compat_ioctl32.c        |   32 +++++++++++-
 drivers/media/video/cx25840/cx25840-core.c  |    4 +-
 drivers/media/video/cx88/cx88-video.c       |    4 +-
 drivers/media/video/msp3400-kthreads.c      |    4 +-
 drivers/media/video/pwc/Kconfig             |    2 -
 drivers/media/video/pwc/pwc-if.c            |    1 
 drivers/media/video/saa7134/saa7134-video.c |    2 -
 drivers/media/video/tuner-types.c           |   14 +++--
 drivers/media/video/v4l1-compat.c           |    4 ++
 drivers/media/video/v4l2-common.c           |    6 +-
 drivers/media/video/videodev.c              |    2 -
 drivers/media/video/vivi.c                  |    4 +-
 include/media/v4l2-dev.h                    |    2 -
 sound/oss/Kconfig                           |    6 +-
 sound/pci/Kconfig                           |   70 ++++++++++++++-------------
 22 files changed, 138 insertions(+), 110 deletions(-)
 rename drivers/media/{video/dsbr100.c => radio/dsbr100.c} (100%)

Which I'm pretty sure is the same as what you ment me to pull.

thanks,

greg k-h
