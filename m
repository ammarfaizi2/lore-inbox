Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbSLLJTJ>; Thu, 12 Dec 2002 04:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSLLJTJ>; Thu, 12 Dec 2002 04:19:09 -0500
Received: from ns.tasking.nl ([195.193.207.2]:3081 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S267451AbSLLJTI>;
	Thu, 12 Dec 2002 04:19:08 -0500
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.5.51 modprobe bttv hangs
In-Reply-To: <20021212003758.246FD2C0BD@lists.samba.org>
References: <20021212003758.246FD2C0BD@lists.samba.org>
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <rnews@altium.nl>
Date: 12 Dec 2002 10:25:05 +0100
Message-ID: <sik7ifk2ry.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rusty" == Rusty Russell <rusty@rustcorp.com.au> writes:

Rusty> 	Thanks for the report.  Looks like bttv does a request module
Rusty> from its init function.  Please try the following fix and report back.

Yep, now it loads my bttv modules.
Thanks. (Still have to try and see if xawtv works.)

FYI
iris:~# modprobe bttv
iris:~# lsmod
Module                  Size  Used by
tuner                  10671  1 [unsafe]
tvaudio                14049  1 [unsafe]
msp3400                17120  1 [unsafe]
bttv                   85118  0
video_buf              13473  1 bttv [permanent]
i2c_algo_bit            8551  2 bttv [unsafe]
i2c_core               19367  5 tuner tvaudio msp3400 bttv i2c_algo_bit
ov511                  75091  0
rtc                     8637  0

		Kees
