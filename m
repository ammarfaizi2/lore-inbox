Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268178AbUHKUu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268178AbUHKUu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268226AbUHKUu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:50:56 -0400
Received: from odin.allegientsystems.com ([208.251.178.227]:47626 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S268178AbUHKUux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:50:53 -0400
Message-ID: <411A86AC.6070403@optonline.net>
Date: Wed, 11 Aug 2004 16:50:52 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [PATCH] SCSI midlayer power management
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net> <20040811201944.GA1550@openzaurus.ucw.cz>
In-Reply-To: <20040811201944.GA1550@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> No, I do not need PIO. I'll probably need host
> controller support, too, but even w/o it it should
> work acceptably. Thanks for the answers.

Well, take note of what James wrote. We do guarantee that there will be 
no further user-initiated disk activity after generic_scsi_suspend. (For 
the disk but not the rest of the bus.) This doesn't apply to 
ioctl's/special requests but as James has rightly pointed out this is 
probably not an issue for realistic intents and purposes. It may 
actually be an advantage.
