Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVBXSv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVBXSv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVBXSv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:51:57 -0500
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:21933 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S261769AbVBXSva convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:51:30 -0500
From: Axel =?iso-8859-1?q?Wei=DF?= <aweiss@informatik.hu-berlin.de>
Organization: =?iso-8859-1?q?Humboldt-Universit=E4t_zu?= Berlin
To: linux-kernel@vger.kernel.org
Subject: Re: Question: warnings about undefined symbols in splitted external modules
Date: Thu, 24 Feb 2005 19:51:10 +0100
User-Agent: KMail/1.7.1
References: <200502241919.15785.aweiss@informatik.hu-berlin.de> <20050224183416.GA8306@mars>
In-Reply-To: <20050224183416.GA8306@mars>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502241951.11043.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

thanks a lot - it works perfectly!

Regards,
			Axel

Am Donnerstag, 24. Februar 2005 19:34 schrieb Sam Ravnborg:
> The trick is to compile both modules at the same time.
> Use a structure like the following:
> dsp/lowlevel	<= Code for one driver
> dsp/middlelevel	<= Code for second driver
>
> Then in the directory dsp/ include a simple kbuild file:
> obj-y := lowlevel/ middlelevel/
>
> And execute Make in that directory.
>
> For convenience you could use the following Makefile:
>
>
> obj-y := lowlevel/ middlelevel/
>
> all:
> 	$(MAKE) -C path-to-kernel-src M=$(PWD)
>
>
> 	Sam

-- 
Humboldt-Universität zu Berlin
Institut für Informatik
Signalverarbeitung und Mustererkennung
Dipl.-Inf. Axel Weiß
Rudower Chaussee 25
12489 Berlin-Adlershof
+49-30-2093-3050
** www.freesp.de **
