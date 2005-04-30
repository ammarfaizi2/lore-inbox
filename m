Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVD3IQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVD3IQA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 04:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVD3IP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 04:15:59 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:54447 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261152AbVD3IPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 04:15:46 -0400
To: hch@infradead.org
CC: 7eggert@gmx.de, smfrench@austin.rr.com, linux-kernel@vger.kernel.org
In-reply-to: <20050430073238.GA22673@infradead.org> (message from Christoph
	Hellwig on Sat, 30 Apr 2005 08:32:38 +0100)
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org>
Message-Id: <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 10:14:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Except that we don't have the concept of a mount owner at the VFS level
> right now, because everyone is adding stupid suid wrapper hacks instead
> of trying to fix the problems for real.

Having a mount owner is not a problem.  Having a good policy for
accepting mounts is rather more so, according to some:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=107705608603071&w=2

Just a little taste of what that policy would involve:

  - global limit on user mounts
  - possibly per user limit on mounts
  - acceptable mountpoints (unlimited writablity is probably a good minimum)
  - acceptable mount options (nosuid, nodev are obviously not)
  - filesystems "safe" to mount by users

I'm not against something like that, but I'd like to hear other
people's opinion before trying to push a solution to mainline.

Thanks,
Miklos
