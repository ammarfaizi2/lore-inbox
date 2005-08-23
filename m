Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVHWJWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVHWJWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVHWJWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:22:33 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24014 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932104AbVHWJWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:22:33 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine ethernet driver bug (reprise...)
Date: Tue, 23 Aug 2005 12:21:59 +0300
User-Agent: KMail/1.5.4
References: <430A0B69.1060304@xs4all.nl>
In-Reply-To: <430A0B69.1060304@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231221.59299.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing maintaner]

On Monday 22 August 2005 20:29, Udo van den Heuvel wrote:
> Hello,
> 
> It appears that the VIA Rhine chipset has some sort of bug which shows
> up in both the standard Linux VIA-Rhine driver and the Rhinefet driver
> that VIA itself provides.
> 
> The difference is that the connection is dropped in case of the standard
> Linux driver for VIA Rhine but that the connection remains OK with the
> Rhinefet driver provided by VIA
> (http://www.viaarena.com/downloads/Source/rhinefet.tgz and other places
> on viaarena.com...).
> So VIA Rhinefet driver consumes more CPU but is also more stable.
> 
> I wrote about this issue before: http://lkml.org/lkml/2005/8/7/82 &
> http://lkml.org/lkml/2005/1/15/47 etc.
> I opened a bugzilla case: http://bugzilla.kernel.org/show_bug.cgi?id=5030
> 
> Who could find out why the standard Linux driver chokes and the Rhinefet
> driver doesn't? Who could fix this bug?

My suggestion was, and still is:

>Since it happens less than once a day, why not just add a code
>to reset the NIC completely in this case, like it is
>typically done in tx_timeout handlers of many NICs, and forget about it?

Do you see any problems in this approach?
--
vda

