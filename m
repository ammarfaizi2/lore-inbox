Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSBNQkn>; Thu, 14 Feb 2002 11:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291781AbSBNQkY>; Thu, 14 Feb 2002 11:40:24 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:32528 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S291778AbSBNQkO>; Thu, 14 Feb 2002 11:40:14 -0500
X-Envelope-From: kraxel@goldbach.in-berlin.de
Date: Thu, 14 Feb 2002 17:37:05 +0100
From: Gerd Knorr <kraxel@strusel007.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 fix build error in drivers/video/vesafb.c
Message-ID: <20020214163705.GA2185@goldbach.in-berlin.de>
In-Reply-To: <200202141501.IAA04461@tstac.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200202141501.IAA04461@tstac.esa.lanl.gov>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -               pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
> +               pmi_base  = (unsigned short*)phys_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);

Looks fine to me.  While s/bus/phys/ isn't the approximate fix for many
drivers, at this place it is correct.  The address is a segment:offset
pointer to a physical memory address somewhere in the VESA BIOS.

  Gerd

-- 
Man muß die Software wacker hüten
weil in der Welt die Hacker wüten
