Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132419AbRDMXkI>; Fri, 13 Apr 2001 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132426AbRDMXj6>; Fri, 13 Apr 2001 19:39:58 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:50440 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132419AbRDMXjl>; Fri, 13 Apr 2001 19:39:41 -0400
Date: Fri, 13 Apr 2001 17:32:56 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: EXPORT_SYMBOL for chrdev_open 2.4.3
Message-ID: <20010413173256.A14267@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It would be nice if chrdev_open were added to ksyms.c along with
blkdev_open since tape devices seem are always registered as character
rather than block devices.  

I am finding that kernel modules that need to open and close a tape 
drive have to export chrdev_open manually on 2.4.3.  Can this get 
exported as well?  Closing is not a problem since the method of 
calling (->release) seems to work OK with SCSI tape devices.

:-)

Jeff


