Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbRBLRbJ>; Mon, 12 Feb 2001 12:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130093AbRBLRa7>; Mon, 12 Feb 2001 12:30:59 -0500
Received: from colorfullife.com ([216.156.138.34]:10245 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129862AbRBLRay>;
	Mon, 12 Feb 2001 12:30:54 -0500
Message-ID: <3A881DD2.46D2EE66@colorfullife.com>
Date: Mon, 12 Feb 2001 18:30:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: LA Walsh <law@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Block driver design issue
In-Reply-To: <3A881A52.962B3ED4@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh wrote:
> 
> 
> I find this duplication of code to be inefficient.  Is there a way to dummy up the
> the 'buf' address so that the "copy_from_user" will copy the buffer from kernel space?
> My assumption is that it wouldn't "just work" (which may also be an invalid assumption).
> 
> Suggestions?  Abuse?
>

set_fs(KERNEL_DS)?

After that call copy_from_user() will accept kernel space addresses.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
