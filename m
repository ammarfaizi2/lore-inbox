Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282848AbRK0H4G>; Tue, 27 Nov 2001 02:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282847AbRK0Hz4>; Tue, 27 Nov 2001 02:55:56 -0500
Received: from web20510.mail.yahoo.com ([216.136.226.145]:3588 "HELO
	web20510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282846AbRK0Hzn>; Tue, 27 Nov 2001 02:55:43 -0500
Message-ID: <20011127075542.70603.qmail@web20510.mail.yahoo.com>
Date: Tue, 27 Nov 2001 08:55:42 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> By the way, I just successfully compiled 2.4.16
(including
> VLAN builtin) with no problems.  It looks like
Maciej is
> compiling MIPS, so it may be a bug particular to
that
> platform?? 

Ben, you remember the patch I sent to you a few weeks
ago ?
VLAN didn't link builtin on alpha because
vlan_proc_cleanup()
in section __exit was called from vlan_proc_init() in
section
__init, and it semt that the absolute offsets between
these
two functions were too big for the linker to put it on
a 16 bit
value (which was the space reserved for a relative
call, it 
seems). So the linker complained and stopped. I had to
extract
the cleanup from __exit and put it into another
function which
worked.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
