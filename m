Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVJXGSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVJXGSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 02:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVJXGSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 02:18:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58789 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751002AbVJXGSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 02:18:32 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Subject: Re: ipw2200 only works as a module?
Date: Mon, 24 Oct 2005 09:17:35 +0300
User-Agent: KMail/1.8.2
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Rob Landley <rob@landley.net>, kronos@kronoz.cjb.net,
       Keenan Pepper <keenanpepper@gmail.com>, linux-kernel@vger.kernel.org,
       jketreno@linux.intel.com
References: <20050926171220.GA9341@dreamland.darkstar.lan> <200510222350.57605.s0348365@sms.ed.ac.uk> <435C0C5E.5000709@linuxwireless.org>
In-Reply-To: <435C0C5E.5000709@linuxwireless.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510240917.35757.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 October 2005 01:19, Alejandro Bonilla Beeche wrote:
> >>>>With CONFIG_IPW2200=y I get:
> >>>>
> >>>>ipw2200: ipw-2.2-boot.fw load failed: Reason -2
> >>>>ipw2200: Unable to load firmware: 0xFFFFFFFE
> >>>>
> >>>>but with CONFIG_IPW2200=m it works fine. If it doesn't work when built
> >>>>into the kernel, why even give people the option?

because we want allyesconfig to compile.

> I have seen this before with users using FC or RH. They end up 
> increasing the timeout of the hotplug event and then it all works. But 
> then again, it only occurs for what I have seen with FC users. Dunno Why.

Firmware-loaded-by-hotplug is a necessary compromise in non-GPL world.
Ideally, firmware can be GPLed too and be included in the module
(u32 firmware_image[NNN]).

With closed firmwares, you should use modules (or wait until kernel will
have usable hotplug before root fs is mounted).
--
vda
