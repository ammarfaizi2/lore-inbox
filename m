Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278239AbRKAHxe>; Thu, 1 Nov 2001 02:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278225AbRKAHxY>; Thu, 1 Nov 2001 02:53:24 -0500
Received: from smtp3.libero.it ([193.70.192.53]:25590 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S278216AbRKAHxQ>;
	Thu, 1 Nov 2001 02:53:16 -0500
Message-ID: <3BE0FF4E.4A9D06AF@alsa-project.org>
Date: Thu, 01 Nov 2001 08:52:46 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i586)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Doug McNaught <doug@wireboard.com>
Cc: Riley Williams <rhw@MemAlpha.cx>, Ville Herva <vherva@niksula.hut.fi>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need blocking /dev/null
In-Reply-To: <Pine.LNX.4.21.0110312256030.28028-100000@Consulate.UFP.CX> <m31yjjz6ws.fsf@belphigor.mcnaught.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:
> 
> Riley Williams <rhw@MemAlpha.cx> writes:
> 
> > Are you sure?
> >
> > > find / -name "wanted-but-lost-download" | eat
> >
> > Doesn't work - you're piping the stdin there, not stderr as per my
> > example above. AFAIK, there's no way to pipe stderr without also piping
> > stdout, hence this sort of solution just doesn't work.
> 
> The Bourne shell is more perverse than you realize:
> 
> $ exec 3>&1; find / -name "wanted-but-lost-download" 2>&1 1>&3 3>&- | eat
> 
> [stolen from "Csh Programming Considered Harmful" by Tom Christiansen]
> 
> Horrible, but does work.  ;)
 
$ find / -name "wanted-but-lost-download" 2>&1 1>&0 | eat

is simpler although dependent on stdin being a tty

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
