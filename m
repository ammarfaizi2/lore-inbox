Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbTCHAmT>; Fri, 7 Mar 2003 19:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261976AbTCHAmT>; Fri, 7 Mar 2003 19:42:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33036 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261955AbTCHAmS>;
	Fri, 7 Mar 2003 19:42:18 -0500
Date: Fri, 7 Mar 2003 16:42:49 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] gen_init_cpio fixes for 2.5.64
Message-ID: <20030308004249.GA23071@kroah.com>
References: <20030305060817.GC26458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305060817.GC26458@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two patches split out of the big klibc patch that fix some
problems in the gen_init_cpio.c code.  The first one allows files to be
added to the cpio image and fixes a padding error, and the second one
fixes some build problems with the cpio image (if there was an error,
the build would not stop.)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/initramfs-2.5

I'll send the two patches as followups to this message to lkml for those
who want to see them.

thanks,

greg k-h


 usr/Makefile        |   26 ++++++++++++---
 usr/gen_init_cpio.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 4 deletions(-)
-----

ChangeSet@1.1125, 2003-03-07 16:46:13-08:00, greg@kroah.com
  kbuild: handle any failures of the gen_init_cpio or initramfs image to stop the build.
  
  This also shows how to add files to the initramfs build, but is 
  commented out.
  
  Patch originally done by Kai.

 usr/Makefile |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)
------

ChangeSet@1.1124, 2003-03-07 16:39:06-08:00, greg@kroah.com
  gen_init_cpio: Add the ability to add files to the cpio image.

Push file://home/greg/linux/BK/initramfs-2.5 -> file://home/greg/linux/BK/bleed-2.5
 usr/gen_init_cpio.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+)
------

