Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312515AbSDEM3v>; Fri, 5 Apr 2002 07:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312513AbSDEM3b>; Fri, 5 Apr 2002 07:29:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9222 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312515AbSDEM3T>; Fri, 5 Apr 2002 07:29:19 -0500
Subject: Re: faster boots?
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 5 Apr 2002 13:45:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bcrl@redhat.com (Benjamin LaHaise),
        akpm@zip.com.au (Andrew Morton),
        rgooch@ras.ucalgary.ca (Richard Gooch), joeja@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <m1sn6apt8r.fsf@frodo.biederman.org> from "Eric W. Biederman" at Apr 04, 2002 11:14:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tT5y-0008EO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My impression is that the time during kernel initialization is either
> spent spinning up disks or in a million device probes and things going
> on behind the scenes.  I haven't had a chance to look farther though.

IDE is less of a problem normally. In the LinuxBIOS case it may become
measurable, and the initial drive spinup has to occur before the firmware
responds. (If I understand it rightly most of the drive firmware is on
the disk). For the spin up/down the IDE folks put it in the drives which 
makes life much simpler

