Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312942AbSDBVu6>; Tue, 2 Apr 2002 16:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312944AbSDBVus>; Tue, 2 Apr 2002 16:50:48 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:14355 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S312942AbSDBVug>;
	Tue, 2 Apr 2002 16:50:36 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chris Rankin <rankincj@yahoo.com>
Date: Tue, 2 Apr 2002 23:50:27 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Screen corruption in 2.4.18
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <140CACD08D8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Apr 02 at 22:43, Chris Rankin wrote:
> 
> I have an i840 motherboard with dual 733 MHz PIIIs and a Matrox G400 
> MAX, and I am also seeing console corruption with 2.4.18. The difference 
> with me is that I *only* see it when I am using xine (CVS) and the 
> SyncFB video plugin, possibly the Xv video plugin sometimes too. When I 
> kill xine, the regular multicoloured rectangle disappears from the console.
> 
> Whatever is causing this console corruption, it doesn't seem to be a VIA 
> bug (in my case, anyway).

It is something completely different - your color rectangle is xine (or Xv)
still painting to framebuffer although X are no longer visible. If
you are using matroxfb, you should see either single color rectangle
(in overlay mode) or picture from xine (in direct paint mode). With
vgacon you'll see single color areas of strange stable characters in overlay
mode, and multicolored areas of strange changing characters in non-overlay
mode.

VIA corruption exists without X, and appears just immediately, during
kernel boot sequence.
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz
                                    
