Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbSJWL77>; Wed, 23 Oct 2002 07:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbSJWL77>; Wed, 23 Oct 2002 07:59:59 -0400
Received: from wilma1.suth.com ([207.127.128.4]:5648 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S264689AbSJWL76>;
	Wed, 23 Oct 2002 07:59:58 -0400
Subject: Re: Linux 2.5.44-ac1
From: Jason Williams <jason_williams@suth.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210231149.g9NBn3G29403@devserv.devel.redhat.com>
References: <200210231149.g9NBn3G29403@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 08:09:03 -0400
Message-Id: <1035374948.24550.47.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 07:49, Alan Cox wrote:
> > code within the ide_iomio_dma function in ide-dma.c The problem shows
> > itself if you only enable the secondary channel of your IDE controller. 
> > I understand this is a strange set up, but it could happen in a machine
> > that boots off of SCSI and uses IDE disks for DATA or a CD Burner. I
> > came up with a fix, some extra sanity checks before this line in the
> > code:
> 
> Yes I saw the report. I've not applied it because I want to know how
> the slave came not to have a hwif->mate even though it was bios disabled.
> There are other things that really mean we should be assigning the hwif
> pointers (eg hot plugging)

That is what I thought you might say. I have been digging around in the
code, trying to figure out the answer to that question myself.  For some
reason, even though that patch worked, it just didn't 'feel' right.  I
was looking for someone to confirm that there was a bigger problem to
search for.  Now I'll go back and hunt down the bigger beast and find
out why that hwif->mate is coming out null.

Jason

