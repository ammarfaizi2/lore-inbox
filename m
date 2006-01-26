Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWAZUNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWAZUNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWAZUNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:13:41 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:61683 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751406AbWAZUNk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:13:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nZJp3ZDKnzNeGCitcLzCdEmVh5+KqDg5SstBMwqVi2cD+G/NAzKy2gjl9b4+Z4Ijocn33JbWESSVfsk2ho11u/bUj5hzlg2Yf35bGqm6yNAFdg8Ic6/cmIXz5x6v/LmOkZkdoaNq1Cv8x3ioaWTQqfUoi5dq6FZ5y6bMtgO0hA8=
Date: Thu, 26 Jan 2006 21:13:10 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: vojtech@suse.cz, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060126211310.f83ed686.diegocg@gmail.com>
In-Reply-To: <20060126194402.GB51864@dspnet.fr.eu.org>
References: <43D7A7F4.nailDE92K7TJI@burner>
	<8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	<43D7B1E7.nailDFJ9MUZ5G@burner>
	<20060125230850.GA2137@merlin.emma.line.org>
	<43D8C04F.nailE1C2X9KNC@burner>
	<20060126161028.GA8099@suse.cz>
	<20060126175506.GA32972@dspnet.fr.eu.org>
	<20060126181034.GA9694@suse.cz>
	<20060126182818.GA44822@dspnet.fr.eu.org>
	<20060126202832.baa824b6.diegocg@gmail.com>
	<20060126194402.GB51864@dspnet.fr.eu.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Jan 2006 20:44:02 +0100,
Olivier Galibert <galibert@pobox.com> escribió:

> Hmmm, since when?  The most recent kernel with a cdrom attached I have
> handy is a 2.6.14-rc2, and it does not give a "media" entry.

2.6.16-rc1 here

> Indeed, since the model is not given in sysfs, at least with
> 2.6.14-rc2 or previous.  There too, /proc/ide has it.  I also have no
> idea what that "GSA" thing is either.

Oops, I got the command wrong, it can tell you the block device *and*
the sysfs path if you use the linux.sysfs_path key (which is non
portable key I guess from the name).

But anyway, it just looked at udev and it can do the same:

root@estel 4/home/diego # udevinfo -q path -n /dev/cd-rw
/block/hdc

(IOW: /sys/block/hdc)

