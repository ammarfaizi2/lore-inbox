Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270800AbRH1MQp>; Tue, 28 Aug 2001 08:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270814AbRH1MQf>; Tue, 28 Aug 2001 08:16:35 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:64386 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S270800AbRH1MQb>; Tue, 28 Aug 2001 08:16:31 -0400
From: Christoph Rohland <cr@sap.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] zero-bounce block highmem I/O, #13
In-Reply-To: <20010827123700.B1092@suse.de> <m3itf85vlr.fsf@linux.local>
	<20010828125520.L642@suse.de> <20010828134141.M642@suse.de>
Organisation: SAP LinuxLab
Date: 28 Aug 2001 14:16:11 +0200
In-Reply-To: <20010828134141.M642@suse.de>
Message-ID: <m3ae0k5qic.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Tue, 28 Aug 2001, Jens Axboe wrote:
> Ok found the bug -- SCSI was accidentally using blk_seg_merge_ok
> when it just wanted to test if we were crossing a 4GB physical
> address boundary or not. Doh! Attached incremental patch should fix
> the SCSI performance issue. I'm testing right now...

Yup, performance is back to 2.4.9 level. But I do not see an
improvement.

I will now do a database import.

Greetings
		Christoph


