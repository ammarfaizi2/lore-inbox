Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUCaVca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUCaVca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:32:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40908 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262545AbUCaV1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:27:04 -0500
Message-ID: <406B3799.5060203@pobox.com>
Date: Wed, 31 Mar 2004 16:26:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de>	 <200403201723.11906.bzolnier@elka.pw.edu.pl>	 <1079800362.11062.280.camel@watt.suse.com>	 <200403201805.26211.bzolnier@elka.pw.edu.pl>	 <1080662685.1978.25.camel@sisko.scot.redhat.com>	 <1080674384.3548.36.camel@watt.suse.com>	 <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com>	 <1080742105.1991.40.camel@sisko.scot.redhat.com> <1080742895.3547.139.camel@watt.suse.com>
In-Reply-To: <1080742895.3547.139.camel@watt.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> On Wed, 2004-03-31 at 09:08, Stephen C. Tweedie wrote:
> 
>>Hi,
>>
>>On Tue, 2004-03-30 at 23:21, Jeff Garzik wrote:
>>
>>
>>>For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which don't 
>>>return until the data is on the platter.
>>
>>fsync() is still really nasty, because that can require that we wait on
>>IO that was submitted by the VM before we knew that there was a
>>synchronous IO wait coming.  
> 
> 
> Yes, it gets ugly in a hurry.  Jeff, look at the whole thread about the
> O_DIRECT read vs buffered write races.  I don't think we can use FUA for

Yes, I'm aware of the thread...


> fsync or O_SYNC without using it for every write.

Why not for O_SYNC?  Is some crazy userspace application flipping this 
bit on and off rapidly?


> We might be able to get away with using it on O_DIRECT.

Nod.

	Jeff



