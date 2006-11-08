Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965906AbWKHO7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965906AbWKHO7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965907AbWKHO7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:59:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43704 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965906AbWKHO7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:59:45 -0500
Subject: Re: New laptop - problems with linux
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen.Clark@seclark.us
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <4551EC86.5010600@seclark.us>
References: <4551EC86.5010600@seclark.us>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 15:59:40 +0100
Message-Id: <1162997980.3138.332.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 09:41 -0500, Stephen Clark wrote:
> Hi list,
> 
> I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core 
> 2 Duo T560,0 2gb pc5400 memory.
>  From checking around it appeared all the
> hardware was well supported by linux - but I am having major problems.
> 
> 
> 1. neither the wireless lan Intel pro 3945ABG or built in ethernet 

you can get the driver for this from ipw3945.sf.net

> RTL-8169C are detected and configured
> 2. the disk which is a 7200rpm Hitachi travelmate transfers data at 1.xx 
> mb/sec
>     according to hdparm. This same drive in my old laptop an HP n5430 with a
>     850 duron the rate was 12-14 mb/sec.

it seems you're using your sata disk in legacy IDE compatibility mode,
and not AHCI mode... usually there is a bios setting to switch this
(but be careful, if you switch it without adding the ahci driver to your
initrd your system won't boot)




-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

