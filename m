Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317188AbSFBOZt>; Sun, 2 Jun 2002 10:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSFBOZs>; Sun, 2 Jun 2002 10:25:48 -0400
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:14211
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S317188AbSFBOZr>; Sun, 2 Jun 2002 10:25:47 -0400
Subject: Re: linux-2.4.19-pre9 and sym53c8xx problem
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF96804.D25F623B@torque.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Jun 2002 16:21:30 +0200
Message-Id: <1023027690.3348.3.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-02 at 02:34, Douglas Gilbert wrote:
> Christian,
> What does the output of "cat /proc/scsi/sg/*" look like?
> 
> Cdrecord should see your plextor writer both as /dev/scd0
> and /dev/sg0 (assuming you don't have any other scsi devices).
> Cdrecord goes on to scan the parallel generic devices (i.e. /dev/pg*)
> if it doesn't find anything suitable on its /dev/sg* scan.
> 
> Your post doesn't supply any information that would link
> this problem with the sym53c8xxx driver. If there is some
> problem then there will be some "noise" in the /var/log/messages
> file [typically showing multiple scsi bus resets].
> 
> BTW The "-vv" switch (and/or "-VV") on cdrecord will yield more
> debug information. strace may also be useful.
> 
> Doug Gilbert
> 

Sorry, was my fault. Lost CONFIG_CHR_DEV_SG during make oldconfig.

Anyway, thanks for your reply. It helped to find the problem...

