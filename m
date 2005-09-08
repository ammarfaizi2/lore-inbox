Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVIHUhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVIHUhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVIHUhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:37:14 -0400
Received: from arkady.gaya.sk ([62.168.75.2]:60393 "EHLO arkady.gaya.sk")
	by vger.kernel.org with ESMTP id S965000AbVIHUhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:37:12 -0400
Subject: Re: [Alsa-devel] Re: Brand-new notebook useless with Linux...
From: Peter Zubaj <pzubaj@gaya.sk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       alsa-devel <alsa-devel@alsa-project.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1126207905.12697.20.camel@mindpipe>
References: <200509081522_MC3-1-A986-1B52@compuserve.com>
	 <1126207905.12697.20.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 22:41:54 +0200
Message-Id: <1126212114.5010.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conexant codec with ID 0x30 - this is AMC97 codec (audio + modem in one
codec) - maybe there is fight between sound and modem driver. On intel
this codec works ok - audio part. Modem part is not working and
snd-intel8x0m have to be in blacklist (otherways audio is not working)
- maybe same problem with ati.

Try to add snd-atiixp-modem to /etc/hotplug/blacklist

Peter Zubaj

On Thu, 2005-09-08 at 15:31 -0400, Lee Revell wrote:
> On Thu, 2005-09-08 at 15:19 -0400, Chuck Ebbert wrote:
> > In-Reply-To: <1125805091.14032.69.camel@mindpipe>
> > 
> > On Sat, 03 Sep 2005 at 23:38:10 -0400, Lee Revell wrote:
> > 
> > > On Sat, 2005-09-03 at 18:58 -0400, Chuck Ebbert wrote:
> > > > I just bought a new notebook.
> > > 
> > > I'd return it if I were you.
> > 
> >  What fun is that?  I have learned that HP/Compaq is hostile to Linux,
> > for one thing, which was interesting (my system is a Compaq Presario
> > V2312US.)
> > 
> >  Can you help me find out why my codec is unknown?  I gave up trying to
> > figure out how to get the codec ID and hacked the source to print it:
> > 
> > 
> > atiixp: codec 0 not available for modem
> > atiixp: no codec available
> > ALSA device list:
> >   #0 ATI IXP rev 2 with 0x43585430 at 0xd0003400, irq 177
> > 
> > 
> > So it's a Conexant codec with ID 0x30 on an atiixp.  OSS has some support
> > for this codec, apparently.
> 
> Wait, that sounds like the modem, not the AC97 audio codec.
> 
> You might be able to get the modem to work with the (proprietary)
> slmodem software modem, or something.  I wouldn't count on it though.
> 
> Does your sound work?
> 
> Lee
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
> Informacia od NOD32
> Tato sprava bola skontrolovana antivirovym systemom NOD32.
> [ Projekt gaya | www.gaya.sk ]

