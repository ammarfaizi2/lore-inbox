Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRDXIgf>; Tue, 24 Apr 2001 04:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRDXIgQ>; Tue, 24 Apr 2001 04:36:16 -0400
Received: from passat.ndh.net ([195.94.90.26]:7569 "EHLO passat.ndh.net")
	by vger.kernel.org with ESMTP id <S131460AbRDXIgL>;
	Tue, 24 Apr 2001 04:36:11 -0400
Date: Tue, 24 Apr 2001 10:36:07 +0200
From: Alex Riesen <a.riesen@traian.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: init_rwsem redefinition warning in usbdevice_fs.h
Message-ID: <20010424103607.B5368@traian.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, again
i do not know whether it may be important, but the warning
makes me anyway curios.
In 2.4.3-ac13 the compiler says that init_rwsem in the
usbdevice_fs.h is redefined. It was previously defined in a .ver-file.

/*
 * sigh. rwsemaphores do not (yet) work from modules
 */
 
#define rw_semaphore semaphore
#define init_rwsem init_MUTEX <<<<<<<<<<<<<<<< here
#define down_read down
#define down_write down
#define up_read up
#define up_write up

Should it be fixed? And, maybe the other define's around
should be fixed too?

Alex Riesen

P.S. the original warning (gcc-2.95.2):

In file included from hub.c:24:
linux-2.4.3-ac13/include/linux/usbdevice_fs.h:170: warning: `init_rwsem' redefined
linux-2.4.3-ac13/include/linux/modules/rwsem-spinlock.ver:2: warning: this is the location of the previous definition


