Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270634AbTGUSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270637AbTGUSaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:30:09 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:21393 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S270634AbTGUSaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:30:01 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: nick black <dank@suburbanjihad.net>
Date: Mon, 21 Jul 2003 20:44:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <7E1E5890331@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jul 03 at 14:33, nick black wrote:
> Petr Vandrovec assumed the extended riemann hypothesis and showed:
> > I do not think that it has anything to do with AGP, as matroxfb does not
> > initiate any AGP transfers. 
> 
> indeed, the issue would only happen after switching from x back to
> console.  regardless, not building agp worked aorund the 2.4 problem for
> me.

In this case, does it happen if you exit X, or only if you are switching
to the console while X are active? If it happens only in second case, then
it is bug (I believe fixed long ago) in XFree mga driver: it was sometime
reprogramming color depth and line length in the accelerator even when
inactive (Gnome1 clock applet running in top right corner was known to
trigger this, depending on clock settings matroxfb would cease to
work in one second or (up to) one minute after VT switch, depending on clock
applet setting... it is possible that it happened only with kernel mga dri
driver active, but I'm not 100% sure).

I know no other workaround than using same color depth and same xres_virtual
(vxres on fbdev & desktop width in X) in X and on the console.
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        

