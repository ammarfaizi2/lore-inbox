Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284118AbRLYAne>; Mon, 24 Dec 2001 19:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284144AbRLYAnY>; Mon, 24 Dec 2001 19:43:24 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:2518 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S284118AbRLYAnJ>;
	Mon, 24 Dec 2001 19:43:09 -0500
Date: Tue, 25 Dec 2001 00:43:05 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <12774562.1009240984@[195.224.237.69]>
In-Reply-To: <20011224225648.I2461@lug-owl.de>
In-Reply-To: <20011224225648.I2461@lug-owl.de>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I've tcpdumped now, and it seemy my old WaveSwitch is
> to blame. The "bad" server actually transmits everything
> (and also tries retransmits etc.), but that never leaves the
> switch again... I've changed the switch port as well as the
> cable. It seems the switch and that network card don't
> like each other...
>
> I've now replaced the network card, everything is fine now.
>
> I've never seen a NIC failing partially, I've learned a lot
> this evening...

Well I dunno if a WaveSwitch is 802.11 (sounds like it might
be), so if it is, I had an identical problem - look under wireless
ethernet at
  http://www.alex.org.uk/T23
Various firmware upgrades fixed it, and crucially a settings
changed, fixed it. Your symptoms sound identical to mine
(and if so it's the basestation you have to fix). Short answer
is change to rfc1042 encapsulation from 802.1h, which (seemingly
illegally) works at 1500 byte MTUs only between some hardware
pairs.

--
Alex Bligh
