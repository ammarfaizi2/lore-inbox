Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVGVAWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVGVAWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 20:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVGVAWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 20:22:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21705 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261929AbVGVAWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 20:22:12 -0400
Subject: Re: [PATCH] serverworks should not take ahold of megaraid'd
	controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       AJ Johnson <blujuice@us.ibm.com>
In-Reply-To: <42E023B2.5030900@us.ibm.com>
References: <42E023B2.5030900@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 01:46:33 +0100
Message-Id: <1121993194.854.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-07-21 at 15:37 -0700, Darrick J. Wong wrote:
> I've noticed what might be a small bug with the serverworks driver in
> 2.6.12.3.  The IBM HS20 blade has a ServerWorks CSB6 IDE controller with
> an optional LSI MegaIDE RAID BIOS (BIOS assisted software raid, iow).

With a binary only proprietary driver.

> (ServerWorks) to IBM.  However, the serverworks driver doesn't notice
> this and will attach to the controller anyway, thus allowing raw access
> to the disks in the RAID.  An unsuspecting user can then read and write
> whatever they want to the drive, which could very well degrade or
> destroy the array, which is clearly not desirable behavior.

It may be appropriate for some vendor situations but it isn't
appropriate for the base kernel to default to assuming the user wants to
use binary only drivers instead of dmraid. Especially as the raid
formats for this hardware are partially known despite no assistance I
know of from the vendor.

Alan

