Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263226AbTCYSYl>; Tue, 25 Mar 2003 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbTCYSYl>; Tue, 25 Mar 2003 13:24:41 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:63672 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S263226AbTCYSYj>;
	Tue, 25 Mar 2003 13:24:39 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Tue, 25 Mar 2003 19:35:24 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.65 + matrox framebuffer: life is good!
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Jurriaan <thunder7@xs4all.nl>,
       <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <74B3EA2366@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Mar 03 at 18:16, James Simmons wrote:
> > > Its for testing and it hasn't been fully ported over yet. Its close. 
> > > I was busy fixing higher level bugs but now that most are fixed I can work 
> > > on the matrox driver again.
> > 
> > There are still some open problems (text mode, hardware cursor), and I missed 
> > something somewhere, as czech font works only on VT1 console with mga-2.5.65 
> > (on other VTs there is some font loaded, but character mapping looks broken). 
> > I have no idea whether it is my problem or James's...
> 
> I have tested font changing. It works. 

I'll have to look into my changes then :-(
  
> > Probably worst problem currently is cursor code: it calls imgblit from interrupt
> > context, and matroxfb's accelerated procedures are not ready to handle
> > such thing (patch hooks cursor call much sooner for primary mga head).
> 
> Fixed now. Also I have a patch that properly fixes image.depth = 0 hack. I 
> will post for people to test. Folks please test the code.

AFAIK you only fixed kmalloc problem. Or is cursor callback disallowed
while doing imgblit/copyarea/fillrect ?
                                                            Petr Vandrovec
                                                            

