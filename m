Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263184AbTCYSFX>; Tue, 25 Mar 2003 13:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263187AbTCYSFX>; Tue, 25 Mar 2003 13:05:23 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:55053 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263184AbTCYSFT>; Tue, 25 Mar 2003 13:05:19 -0500
Date: Tue, 25 Mar 2003 18:16:24 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Jurriaan <thunder7@xs4all.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.65 + matrox framebuffer: life is good!
In-Reply-To: <20030324083859.GA5881@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0303251813500.4568-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Its for testing and it hasn't been fully ported over yet. Its close. 
> > I was busy fixing higher level bugs but now that most are fixed I can work 
> > on the matrox driver again.
> 
> There are still some open problems (text mode, hardware cursor), and I missed 
> something somewhere, as czech font works only on VT1 console with mga-2.5.65 
> (on other VTs there is some font loaded, but character mapping looks broken). 
> I have no idea whether it is my problem or James's...

I have tested font changing. It works. 
 
> Probably worst problem currently is cursor code: it calls imgblit from interrupt
> context, and matroxfb's accelerated procedures are not ready to handle
> such thing (patch hooks cursor call much sooner for primary mga head).

Fixed now. Also I have a patch that properly fixes image.depth = 0 hack. I 
will post for people to test. Folks please test the code.



