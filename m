Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVFJG4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVFJG4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 02:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVFJG4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 02:56:46 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11404 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262197AbVFJG4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 02:56:43 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <abonilla@linuxwireless.org>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Netdev list'" <netdev@oss.sgi.com>,
       "'kernel list'" <linux-kernel@vger.kernel.org>,
       "'James P. Ketrenos'" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
Date: Fri, 10 Jun 2005 09:56:16 +0300
User-Agent: KMail/1.5.4
References: <002a01c56cff$fb64ba70$600cc60a@amer.sykes.com>
In-Reply-To: <002a01c56cff$fb64ba70$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506100956.16031.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 June 2005 17:31, Alejandro Bonilla wrote:
> 
> > What is so nice about this? That Linux novice user with his new lappie
> > will join a neighbor's network every time he powers up the lappie,
> > even without knowing that?
> >
> > That will be analogous to me plugging ethernet cable into the
> > switch and
> > wanting it to work, without any IP addr config, even without
> > DHCP client.
> > Just power up the box (or modprobe an eth module) and it
> > works! Cool, eh?
> >
> 
> You want things one way, I like them in another way. Whoever makes this
> decision should just know that we would like to have an option to make it
> load with or without the ASSOC on.

But you already _have_ the option to associate. Just issue
appropriate iwconfig command (or embed one in startup script).

> James already said to use the options ipw2100 disable=1 if you don't want it
> to associate everytime on boot.

Do we have to add such option to each and every wireless driver now?
That would be wrong since iwconfig already exists.

> At the end, who decides this?

User. As I said, with no automatic assoc at module load user still
may easily attain that with iwconfig.

Adding kernel level wireless autoconfiguration duplicates the effort.
Since I am not going to give up a requirement to be able to stay radio
silent at boot (me too wants freedom, not only you), you need to add
disable=1 module parameter to each driver, which adds to the mess.

ALSA does the Right Thing. Sound is completely muted out at module load.
It's a user freedom to set desired volume level after that.
--
vda

