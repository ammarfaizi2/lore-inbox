Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280662AbRKNP1U>; Wed, 14 Nov 2001 10:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280655AbRKNP1Q>; Wed, 14 Nov 2001 10:27:16 -0500
Received: from rj.sgi.com ([204.94.215.100]:28635 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S280634AbRKNPZm>;
	Wed, 14 Nov 2001 10:25:42 -0500
Subject: Re: RAID-5 build time calculation?
From: Steve Lord <lord@sgi.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111141437440.5877-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0111141437440.5877-100000@mustard.heime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 14 Nov 2001 09:20:40 -0600
Message-Id: <1005751240.23586.18.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-14 at 07:40, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> I apologize if this is more of a support question, but I couldn't find it
> anywhere...
> 
> How long time may I have to wait for kernel to build a software RAID-5 on
> 12 18GB 15k SCSI drives? Algorithm is set to left-symmetric and persistent
> superblock is 1.
> 
> What can be done to speed this up_
> 
> thanks
> 

I have seen the raid resync get stuck at really slow rates, it seems to
start running faster if you echo a larger number into

/proc/sys/dev/raid/speed_limit_min

You can look at /proc/mdstat to see how the rebuild is progressing.

Steve


