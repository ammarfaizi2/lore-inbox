Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSGHBBg>; Sun, 7 Jul 2002 21:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSGHBBf>; Sun, 7 Jul 2002 21:01:35 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:11529 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S316693AbSGHBBe>;
	Sun, 7 Jul 2002 21:01:34 -0400
From: "Tim Pepper" <tpepper@vato.org>
Date: Sun, 7 Jul 2002 18:04:08 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.25
Message-ID: <20020707180408.A11779@vato.org>
Mail-Followup-To: Tim Pepper <tpepper@vato.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jul 05, 2002 at 04:54:20PM -0700
X-Mailer: None of your business.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05 Jul at 16:54:20 -0700 torvalds@transmeta.com done said:
> 
> The other thing that we should sort out eventually is the unified naming
> for disk devices, now that both IDE and SCSI are starting to have some
> support for driverfs.  Let's make sure that we _can_ have sane ways of
> accessing a disk, without having to care whether it is IDE or SCSI or
> anything else.

...and a way that scales better when naming large numbers of disks than
disk_name()'s stuff like:
     sprintf(buf, "sd%c%c", 'a' + unit / 26, 'a' + unit % 26);


t.
