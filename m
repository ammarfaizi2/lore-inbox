Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272790AbTHKSbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272989AbTHKSay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:30:54 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:60857 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272980AbTHKSaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:30:05 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jocelyn Mayer <l_indien@magic.fr>
Date: Mon, 11 Aug 2003 20:29:31 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test2 does not boot with matroxfb
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9D9B6471D22@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Aug 03 at 20:01, Jocelyn Mayer wrote:
> I now run a VGA console kernel without agpgart with a 16bps X.
> 
> So, there seems to be two issues:
> - broken matrox fb: I lose the synchro when switching from X to fb.
>   fbset configuration is lost when switching consoles.

It is feature, not a bug. fbset does not work on 2.6.x kernels
anymore. Apply 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0-t3-c1149.gz
if you prefer 2.4.x behavior.

Also if you are using DRI, even latest XFree mga driver I found still 
reprograms hardware even if XFree server is not on a foreground, so you 
must use same color depth and vxres for both X and console, and even in 
this configuration display corruption on console may occur from time to
time...
                                            Petr Vandrovec
                                            

