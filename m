Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSFRUH0>; Tue, 18 Jun 2002 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317594AbSFRUHZ>; Tue, 18 Jun 2002 16:07:25 -0400
Received: from fly.hiwaay.net ([208.147.154.56]:40205 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S317593AbSFRUGz>;
	Tue, 18 Jun 2002 16:06:55 -0400
Date: Tue, 18 Jun 2002 15:06:54 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/scsi/map
Message-ID: <20020618150654.A506017@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Doug Ledford  <dledford@redhat.com> said:
>Umm, this patently fails to meet the criteria you posted of "stable device 
>name".  Adding a controller to a system is just as likely to blow this 
>naming scheme to hell as it is to blow the traditional linux /dev/sd? 
>scheme.  IOW, even though the /proc/scsi/map file looks nice and usefull, 
>it fails to solve the very problem you are trying to solve.

I use OSF/1^WDigital Unix^WCompaq^WHP Tru64 Unix here at work, and with
version 5, they've got a nice persistent device naming system (I don't
claim to know how it works however).  The first hard drive found is
/dev/disk/dsk0, the second is /dev/disk/dsk1, etc.  It doesn't matter
how you get to the drive (which is important if you want multipathing -
the controller and bus should NOT figure into the device name or you are
going to have problems).  If you remove dsk0, there won't be another
dsk0 (unless you clean it out of the device database).

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
