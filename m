Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270545AbTGPOfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270841AbTGPOfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:35:18 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:39133 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S270545AbTGPOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:35:07 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Peter Osterlund <petero2@telia.com>
Subject: Re: 2.6.0-test1: Synaptics driver makes touchpad unusable
Date: Wed, 16 Jul 2003 16:49:55 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307151244.53276.gallir@uib.es> <200307151753.59165.gallir@uib.es> <m2brvvh3vz.fsf@telia.com>
In-Reply-To: <m2brvvh3vz.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307161649.55783.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 23:33, Peter Osterlund shaped the electrons to shout:
> Does it help to make the timeout even longer? (15 seconds for example)
> Does it help to disable the reset sequence altogether, like this?
>
> diff -u -r -N linux-2.6.0-test1/drivers/input/mouse/synaptics.c
> linux-tmp/drivers/input/mouse/synaptics.c ---
> linux-2.6.0-test1/drivers/input/mouse/synaptics.c	Sat Jul 12 00:17:19 2003
> +++ linux-tmp/drivers/input/mouse/synaptics.c	Tue Jul 15 23:31:01 2003 @@
> -81,6 +81,8 @@
>  {
>  	unsigned char r[2];
>
> +	return 0;
> +
>  	if (psmouse_command(psmouse, r, PSMOUSE_CMD_RESET_BAT))
>  		return -1;
>  	if (r[0] == 0xAA && r[1] == 0x00)


No, it didn't help. With the above patch, the x server gives the following 
errors:
Query no Synaptics: 0000C8
(EE) TouchPad no synaptics  touchpad detected and no repeater device
(EE) TouchPad Unable to query/initialize Synaptics hardware.




-- 
  ricardo galli       GPG id C8114D34

