Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274072AbRISQcg>; Wed, 19 Sep 2001 12:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274099AbRISQc0>; Wed, 19 Sep 2001 12:32:26 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:62471 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274072AbRISQcQ>; Wed, 19 Sep 2001 12:32:16 -0400
Message-ID: <3BA8C842.ED7628A3@osdlab.org>
Date: Wed, 19 Sep 2001 09:30:58 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, crutcher+kernel@datastacks.com,
        lkml <linux-kernel@vger.kernel.org>, paulus@au.ibm.com
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> 1.  Was this stuff tested?  How ???
> 
> It always sets console_loglevel and then restores
> console_loglevel from orig_log_level, so Alt+SysRq+#
> handling is severely broken.
> 
> If someone (Crutcher ?) wants to patch it, that's fine.
> If I patched it, I would just add a
>   next_loglevel = -1;
> at the beginning of __handle_sysrq_nolock() and then
> let the loglevel handler(s) set next_loglevel.
> If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
> set console_loglevel to next_loglevel.


I'll post a patch for these after I test it (soon).

~Randy
