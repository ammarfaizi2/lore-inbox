Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267437AbUGNQlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267437AbUGNQlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUGNQlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:41:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30123 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267437AbUGNQlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:41:05 -0400
Message-ID: <40F56212.7040500@pobox.com>
Date: Wed, 14 Jul 2004 12:40:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Genady Okrain <mafteah@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't compile sg.c 2.6.8-rc1-mm1
References: <30a4d01b04071401457267defa@mail.gmail.com> <40F55763.4080600@pobox.com> <20040714163933.GD7308@fs.tum.de>
In-Reply-To: <20040714163933.GD7308@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Jul 14, 2004 at 11:55:15AM -0400, Jeff Garzik wrote:
> 
>>Genady Okrain wrote:
>>
>>>I am using gcc-3.4.1
>>>
>>> CC [M]  drivers/scsi/sg.o
>>>drivers/scsi/sg.c: In function `sg_ioctl':
>>>drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call
>>>to 'sg_jif_to_ms': function body not available
>>>drivers/scsi/sg.c:930: sorry, unimplemented: called from here
>>>make[2]: *** [drivers/scsi/sg.o] Error 1
>>>make[1]: *** [drivers/scsi] Error 2
>>>make: *** [drivers] Error 2
>>
>>
>>Looks like a compiler bug.
> 
> 
> No, it's an inline that is used before it's defined.
> 
> I'll send a fix soon.

Wrong.  The prototype is at the top of the file, as it should be.

	Jeff



