Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWI3T4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWI3T4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 15:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWI3T4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 15:56:11 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8863 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751810AbWI3T4I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 15:56:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Date: Sat, 30 Sep 2006 21:58:02 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl> <200609290135.33683.rjw@sisk.pl> <200609301615.47746.arnd@arndb.de>
In-Reply-To: <200609301615.47746.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609302158.03692.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 30 September 2006 16:15, Arnd Bergmann wrote:
> Am Friday 29 September 2006 01:35 schrieb Rafael J. Wysocki:
> > @@ -119,7 +119,18 @@ extern int snapshot_image_loaded(struct
> >  #define SNAPSHOT_SET_SWAP_FILE         _IOW(SNAPSHOT_IOC_MAGIC, 10,
> > unsigned int) #define
> > SNAPSHOT_S2RAM                 _IO(SNAPSHOT_IOC_MAGIC, 11) #define
> > SNAPSHOT_PMOPS                 _IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
> > -#define SNAPSHOT_IOC_MAXNR     12
> > +#define SNAPSHOT_SET_SWAP_AREA         _IOW(SNAPSHOT_IOC_MAGIC, 13, void *) 
> > +#define SNAPSHOT_IOC_MAXNR     13
> 
> Your definition looks wrong, '_IOW(SNAPSHOT_IOC_MAGIC, 13, void *)' means
> your ioctl passes a pointer to a 'void *'.
> 
> You probably mean 
> 
> #define SNAPSHOT_SET_SWAP_AREA _IOW(SNAPSHOT_IOC_MAGIC, 13, \
> 						struct resume_swap_area)

No.  I mean the ioctl passes a pointer, the size of which is sizeof(void *).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
