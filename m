Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTKYJAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTKYJAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:00:22 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:12494 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262118AbTKYJAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:00:21 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 25 Nov 2003 09:50:56 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: "Subbu K. K." <kksubramaniam@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fix for "MT2032 Fatal Error: PLLs didn't lock"
Message-ID: <20031125085056.GA5440@bytesex.org>
References: <20031124004835.3abbb4cf.akpm@osdl.org> <20031124114620.GA29771@bytesex.org> <1069743507.1270.2.camel@dog.blr.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069743507.1270.2.camel@dog.blr.novell.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Except in one place where there is an implicit conversion to signed ints
> in line 746:
> 
> 746         mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */, 

Sure?  Both freq and second mt2032_set_if_freq argument are declared
unsigned int ...
What happens with "62500" changed to "(unsigned)62500" ?

> > tuner: tv freq set to 140.25
> > mt2032_set_if_freq rfin=140250000 if1=1090000000 if2=38900000 from=32900000 to=39900000
> Thanks for the clue. Perhaps the problem is gcc/athlon related?

Maybe.  gcc 3.3.1 here.

  Gerd

-- 
You have a new virus in /var/mail/kraxel
