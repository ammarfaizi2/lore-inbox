Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270264AbRIAKXu>; Sat, 1 Sep 2001 06:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270266AbRIAKXk>; Sat, 1 Sep 2001 06:23:40 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:47109 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S270264AbRIAKXY>; Sat, 1 Sep 2001 06:23:24 -0400
Date: Sat, 1 Sep 2001 12:08:40 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Olivier Crete <Tester@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
Message-ID: <20010901120839.P11997@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.33.0108311244070.2899-100000@TesterTop.PolyDom> <Pine.LNX.4.33.0109010022440.1295-100000@TesterTop.PolyDom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109010022440.1295-100000@TesterTop.PolyDom>; from Tester@videotron.ca on Sat, Sep 01, 2001 at 12:50:30AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 12:50:30AM -0400, Olivier Crete wrote:
> Ok, I've tried removing different parts of the kernel and I have been able
> to find that the instability (repetable freezes) start to appear when the
> yenta_socket.o module is loaded. I dont see the link between this module
> and the events that trigger the freezes... It crashes when I do the
> following things: use any of the non-keyboard buttons (thinkpad buttons
> and volume control), brightness control, etc.. These buttons fn-X
> combination have in common that they do not generate a scancode as shown
> by showkey.

Hmm, I had a similar kind of freeze when using USB hotplug and PCMCIA.
I could solve mine by only having CardBus support in the kernel:

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
