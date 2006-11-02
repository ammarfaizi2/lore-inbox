Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752653AbWKBVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbWKBVoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbWKBVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:44:32 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:32707 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752653AbWKBVob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:44:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [2.6.18] Suspend to ram and SATA
Date: Thu, 2 Nov 2006 22:43:02 +0100
User-Agent: KMail/1.9.1
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <454A61B0.9010306@gmail.com>
In-Reply-To: <454A61B0.9010306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611022243.02992.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2 November 2006 22:22, Maciej Rutecki wrote:
> I have problem with suspend to ram, and my SATA drive. When I try:
> 
> echo mem > /sys/power/state
> 
> system goes standby, but when doing the resume it
> would come back and have I/O errors similar like this ((copied from
> paper notes, the disk is no longer writable when the error happens)
> 
> kernel: journal commit I/O error
> end_request: I/O error, dev sda, sector xxxxxxxx
> sd 0:0:0:0: SCSI error return code: 0xxxxxx
> 
> Problem is similar like this:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111409309804068&w=2
> http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux
> http://lkml.org/lkml/2005/9/23/97
> 
> I test it in 2.6.18.1 (with initrd) and 2.6.18 (with and without initrd).
> 
> Hardware: HP/Compaq nx6310

Can you please test 2.6.19-rc4 with CONFIG_DISABLE_CONSOLE_SUSPEND
unset?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
