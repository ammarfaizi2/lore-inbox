Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUC3Wj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUC3Wj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:39:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261462AbUC3Wi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:38:56 -0500
Message-ID: <4069F6F0.305@pobox.com>
Date: Tue, 30 Mar 2004 17:38:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com> <200403310040.43034.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403310040.43034.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 31 of March 2004 00:21, Jeff Garzik wrote:
> 
>>Stephen C. Tweedie wrote:
>>
>>>Yep.  It scares me to think what performance characteristics we'll start
>>>seeing once that gets used everywhere it's needed, though.  If every raw
>>>or O_DIRECT write needs a flush after it, databases are going to become
>>>very sensitive to flush performance.  I guess disabling the flushing and
>>>using disks which tell the truth about data hitting the platter is the
>>>sane answer there.
>>
>>For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which don't
>>return until the data is on the platter.
> 
> 
> Do you know of any drive supporting it?  I don't.


Newer SATAs do...

	Jeff



