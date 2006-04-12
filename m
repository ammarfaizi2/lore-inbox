Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWDLTTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWDLTTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 15:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWDLTTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 15:19:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:526 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750918AbWDLTTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 15:19:46 -0400
Date: Wed, 12 Apr 2006 20:18:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is platform_device_register_simple() deprecated?
Message-ID: <20060412191835.GA32599@flint.arm.linux.org.uk>
Mail-Followup-To: Rene Herman <rene.herman@keyaccess.nl>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <443D3DED.5030009@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443D3DED.5030009@keyaccess.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 07:50:37PM +0200, Rene Herman wrote:
> Hi Greg, Russel, Dmitry.
> 
> ALSA is using platform_device_register_simple(). Jean Delvare pointed:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113398060508534&w=2
> 
> out, where _simple looks to be slated for removal. Is this indeed the 
> case? ALSA isn't using the resources -- doing a manual alloc/add would 
> not be a problem...

It would be good to remove the old (restricted) API - I'm of the opinion
that having too many interfaces just adds extra maintainence burden, so
we should strive to ensure that old APIs are deprecated and removed in
a timely fashion.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
