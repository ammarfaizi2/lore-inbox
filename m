Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267336AbUHIXFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbUHIXFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267337AbUHIXFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 19:05:13 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:1191 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267336AbUHIXFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 19:05:07 -0400
References: <1092082920.5761.266.camel@cube>
Message-ID: <cone.1092092365.461905.29067.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 08:59:25 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan writes:


> Joerg:
>    "WARNING: Cannot do mlockall(2).\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to lock memory.\n"
>    "         If the computer is not idle, the CD may be ruined.\n"
> 
> Joerg:
>    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to hog the CPU.\n"
>    "         If the computer is not idle, the CD may be ruined.\n"

Huh? That can't be right. Every cd burner this side of the 21st century has 
buffer underrun protection. I've burnt cds _while_ capturing and encoding 
video using truckloads of cpu and I/O without superuser privileges, had all 
the cdrecord warnings and didn't have a buffer underrun. Last time I gave 
superuser privilege to cdrecord it locked my machine - clearly it wasn't 
rt_task safe.

Con

