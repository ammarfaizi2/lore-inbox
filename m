Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUBKUxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUBKUxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:53:14 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:63880 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S264359AbUBKUxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:53:08 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Rik van Riel <riel@redhat.com>, Jon Burgess <lkml@jburgess.uklinux.net>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved writes
Date: Thu, 12 Feb 2004 05:02:39 +0800
User-Agent: KMail/1.5.4
Cc: linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402120502.39300.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 04:28, Rik van Riel wrote:
> On Wed, 11 Feb 2004, Jon Burgess wrote:
> 
> > Write speed in MB/s using an ext2 filesystem for 1 and 2 streams:
> > Num streams:     1      2
> > linux-2.4.22   10.47  6.98
> > linux-2.6.2     9.71  0.34
> 
> > During the disk light is on solid and it really slows any other disk 
> > access. It looks like the disk is continuously seeking backwards and 
> > forwards, perhaps re-writing the meta data.
> 
> Just for fun, could you also try measuring how long it takes
> to read back the files in question ?
> 
> Both individually and in parallel...
> 

2.4 has a deadline scheduler. 2.6 default is anticipatory.

Could you please boot with scheduler=deadline to compare apples with apples.

Regards
Michael


