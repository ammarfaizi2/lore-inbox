Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161323AbWHJNG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161323AbWHJNG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161321AbWHJNG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:06:57 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:58338 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161320AbWHJNG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:06:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TVI+S7CrYvEdN1b5se5LpAMX0HdufEwzztFqKzbZbroPsITLhh3at+acgwnPJevOE7582gbEZAt63PjFwOXknoZSDDg+0FlVrzmpk4lixzvUhEsZnwQv5u7dc0gZWQker6TZJSTSfw+YmQx1BHEc5odSz4MmKL5Y6VIQ8uf4NvU=
Message-ID: <6bffcb0e0608100606i7deb9006ie7064f4d18a4f237@mail.gmail.com>
Date: Thu, 10 Aug 2006 15:06:55 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060810063532.GF11829@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	 <6bffcb0e0608090720g2ac739desd25a77e3c98ef268@mail.gmail.com>
	 <6bffcb0e0608091544l376c37c6j5c766b38426c318b@mail.gmail.com>
	 <20060810063532.GF11829@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Aug 10 2006, Michal Piotrowski wrote:
> > Hi,
> >
> > On 09/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > >On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > >> The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
> > >>
> > >>
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
> > >>
> > >
> > >When I want to halt system I type "init 0", but it stops on
> > >
> > >Halting system...
> > >Synchronizing SCSI cache for disk sda
> > >Shutdown: hda
> > >
> > >Problem appears on 2.6.18-rc3-mm*. I guess that this is an IDE or ACPI bug.
> > >I'll revert IDE and ACPI patches. If it won't help, I'll do binary search.
> >
> > It's a git-block.patch
> >
> > Jens, can you look at this?
> >
> > Here is a config file
> > http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/mm-config2
>
> It's the already solved bug, I believe. The version referenced above
> still has the fixed REQ_TYPE_ATA_TASKFILE and ->end_io_data for suspend
> problem.
>
> Let me know if it works or not with this applied.
>

It works. Thanks!

Andrew, please add this patch to -mm.

> --
> Jens Axboe
>
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
