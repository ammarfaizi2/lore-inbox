Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBWVop>; Fri, 23 Feb 2001 16:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRBWVoi>; Fri, 23 Feb 2001 16:44:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17934 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129232AbRBWVo1>; Fri, 23 Feb 2001 16:44:27 -0500
Message-ID: <3A96D9AE.C320EC1@transmeta.com>
Date: Fri, 23 Feb 2001 13:44:14 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Quim K Holland <qkholland@my-deja.com>
CC: dledford@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: cpu_has_fxsr or cpu_has_xmm?
In-Reply-To: <200102232051.MAA18803@mail17.bigmailbox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quim K Holland wrote:
> 
> DL> As to the correctness, the mxcsr register really only exists
> DL> if you have xmm, so the xmm is the correct test. However,...
> 
> DL> ...  User space programmers should be checking for xmm
> DL> capability themselves before ever paying attention to mxcsr
> DL> anyway, so it's not an end of the world error.
> 
> If that is the case, wouldn't it be simpler to always return
> tsk->thread.i387.fxsave.mxcsr from this function, and initialize
> that field to 0x1f80 (whatever that magic number means) when
> the structure is built?
> 

No, because the CPU *may* overwrite it when you do an FXSAVE.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
