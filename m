Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271943AbRIDLSn>; Tue, 4 Sep 2001 07:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271950AbRIDLSd>; Tue, 4 Sep 2001 07:18:33 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:22288 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S271949AbRIDLSV>;
	Tue, 4 Sep 2001 07:18:21 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Date: Tue, 4 Sep 2001 13:17:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <27DBFC202D6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Sep 01 at 12:09, VDA wrote:
> min2 performs a very strict checking.
> min3 gives you full control, but checks for too small target type.
> Do anybody see any flaws? Any improvements?
> For compiler folks: Why GCC compiles ...f(1);f(1);f(1)... to
> ...
>         pushl $1
>         call f
>         addl $32,%esp  <-- My grandma optimizes better
>         addl $-12,%esp <-- ?
>         pushl $1
>         call f
>         addl $16,%esp  <-- ?
>         addl $-12,%esp <-- ?

Compile with 'gcc -mpreferred-stack-boundary=2', gcc generates
unbelievable stupid code for other values.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
