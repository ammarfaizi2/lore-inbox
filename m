Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266616AbRGEDCb>; Wed, 4 Jul 2001 23:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266617AbRGEDCV>; Wed, 4 Jul 2001 23:02:21 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:32529 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S266616AbRGEDCK>; Wed, 4 Jul 2001 23:02:10 -0400
Date: Thu, 5 Jul 2001 02:19:04 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Trevor Hemsley <Trevor-Hemsley@dial.pipex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia lockup inserting or removing cards in 2.4.5-ac{13,22}
Message-ID: <20010705021904.G30999@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010704235854Z266582-17721+8482@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010704235854Z266582-17721+8482@vger.kernel.org>; from Trevor-Hemsley@dial.pipex.com on Thu, Jul 05, 2001 at 12:41:15AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 12:41:15AM +0000, Trevor Hemsley wrote:
> OK, I've done quite a lot more work on this. It isn't 2.4.5, I'd 
> compiled USB support in when I went to 2.4.5 and it's that that causes
> the problems. I backed out all changes made between 2.4.2 and 2.4.5 in
> drivers/pcmcia and that made no difference to the lockup so then I 
> went back to the .config file from 2.4.2 and that worked.

Hmm, Cardbus and USB problems... you probably have both Cardbus and
i82365 support in your kernel configuration. Your .config file should
have this:

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set

That fixed it for me for at least three laptops.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
