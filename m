Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTI3KJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTI3KIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:08:54 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:16295 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261270AbTI3KIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:08:52 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Erik Hensema <erik@hensema.net>
Date: Tue, 30 Sep 2003 12:08:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matroxfb still broken in -test6
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1AA960315C3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 03 at 9:24, Erik Hensema wrote:
> The simptoms are:
> 
> - large white bar to the right of the pengiun logo on booting
> - (mostly) yellow distortion in the background: parts of the screen that
>   should be black, are distorted with a semi-regular pattern. Each line of
>   scrolling adds around 5 lines worth of distorion to the bottom of the
>   screen. The distorion works its way up until the entire screen is filled
>   with it.
>   Switching to and from another vc clears it.

Are you sure that you are not running XFree when this yellow distortion
occurs? It looks to me like that you are using XFree with DRI in 32bpp,
while your console uses 8bpp. Do not do that! DRI permanently smashes
accelerator state with its own setting, and this makes any other
accelerated work on the system unusable. So either disable matroxfb's
acceleration, or explain to your mga_dri that "screen invisble" should
mean "you do not own hardware, dude!".
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

