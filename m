Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUC3WWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUC3WWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:22:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:900 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261416AbUC3WWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:22:05 -0500
Message-ID: <4069F2FC.90003@pobox.com>
Date: Tue, 30 Mar 2004 17:21:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Chris Mason <mason@suse.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de>	 <200403201723.11906.bzolnier@elka.pw.edu.pl>	 <1079800362.11062.280.camel@watt.suse.com>	 <200403201805.26211.bzolnier@elka.pw.edu.pl>	 <1080662685.1978.25.camel@sisko.scot.redhat.com>	 <1080674384.3548.36.camel@watt.suse.com> <1080683417.1978.53.camel@sisko.scot.redhat.com>
In-Reply-To: <1080683417.1978.53.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> Yep.  It scares me to think what performance characteristics we'll start
> seeing once that gets used everywhere it's needed, though.  If every raw
> or O_DIRECT write needs a flush after it, databases are going to become
> very sensitive to flush performance.  I guess disabling the flushing and
> using disks which tell the truth about data hitting the platter is the
> sane answer there.


For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which don't 
return until the data is on the platter.

	Jeff



