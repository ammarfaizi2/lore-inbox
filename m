Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUCaVdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbUCaVcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:32:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262556AbUCaV1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:27:45 -0500
Message-ID: <406B37C4.7050402@pobox.com>
Date: Wed, 31 Mar 2004 16:27:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Chris Mason <mason@suse.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de>	 <200403201723.11906.bzolnier@elka.pw.edu.pl>	 <1079800362.11062.280.camel@watt.suse.com>	 <200403201805.26211.bzolnier@elka.pw.edu.pl>	 <1080662685.1978.25.camel@sisko.scot.redhat.com>	 <1080674384.3548.36.camel@watt.suse.com>	 <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com> <1080742105.1991.40.camel@sisko.scot.redhat.com>
In-Reply-To: <1080742105.1991.40.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2004-03-30 at 23:21, Jeff Garzik wrote:
> 
> 
>>For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which don't 
>>return until the data is on the platter.
> 
> 
> fsync() is still really nasty, because that can require that we wait on
> IO that was submitted by the VM before we knew that there was a
> synchronous IO wait coming.  SCSI also has an FUA bit that can make a
> difference if you've got writeback caching enabled.  (And FUA on read
> can bypass drive writethrough caches, too, for media verification.)

Agreed, but I did not mention fsync(), since that would not be 
appropriate to FUA like O_DIRECT or O_SYNC might be.

	Jeff




