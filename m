Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263414AbTDSQdX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTDSQdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:33:23 -0400
Received: from khms.westfalen.de ([62.153.201.243]:64158 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP id S263414AbTDSQdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:33:22 -0400
Date: 19 Apr 2003 13:45:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8kAuh4Wmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.53.0304181512220.22901@chaos>
Subject: Re: [TRIVIAL] kstrdup
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com> <Pine.LNX.4.53.0304181323400.22493@chaos> <3EA0469D.7090602@pobox.com> <3EA0469D.7090602@pobox.com> <Pine.LNX.4.53.0304181512220.22901@chaos>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@chaos.analogic.com (Richard B. Johnson)  wrote on 18.04.03 in <Pine.LNX.4.53.0304181512220.22901@chaos>:

> The test for every byte transferred is, quite obviously, correct.
> It is also, quite obviously, non optimum.

Actually, that is very much not obvious.

Especially if you're familiar with architectures where every move has an  
implicit test (typically for zero and sign), and so checking for the zero  
byte during the move is quite obviously the only sane thing to do - the  
version with a count is slower, because the inner loop does more. (Those  
architectures typically don't have a REP-style prefix.)

MfG Kai
