Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274321AbRIVHiM>; Sat, 22 Sep 2001 03:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274388AbRIVHiC>; Sat, 22 Sep 2001 03:38:02 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:11536 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274321AbRIVHhm>; Sat, 22 Sep 2001 03:37:42 -0400
Date: 22 Sep 2001 09:16:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <89M2o6gXw-B@khms.westfalen.de>
In-Reply-To: <15764.1001122752@ocs3.intra.ocs.com.au>
Subject: Re: Announce: ksymoops 2.4.3 is available
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0109211238010.1454-100000@base.torri.linux> <15764.1001122752@ocs3.intra.ocs.com.au>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaos@ocs.com.au (Keith Owens)  wrote on 22.09.01 in <15764.1001122752@ocs3.intra.ocs.com.au>:

> >symbol.c:220:58: warning: trigraph ??> ignored
> >symbol.c:221:44: warning: trigraph ??> ignored
> >symbol.c:225:49: warning: trigraph ??> ignored
> >symbol.c:226:35: warning: trigraph ??> ignored
>
> I believe that is a gcc bug.  The text is
>             snprintf(map, size,
>                      options->hex ? "<END_OF_CODE+%llx/????>"
>                     : "<END_OF_CODE+%lld/????>",
>                 offset);
> gcc is complaining about trigraphs but they are inside a string
> constant, not in code.  IMHO gcc should not flag trigraphs in string
> constants, report it as a gcc bug.

Trigraphs are defined to work within string constants. In fact, the  
standard requires trigraphs to be replaced before the very first  
tokenizing of the input.

How else could the ??/ trigraph for \ possibly work?

Gcc is correct.

MfG Kai
