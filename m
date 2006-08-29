Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWH2QbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWH2QbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWH2QbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:31:03 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:61390
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S965070AbWH2QbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:31:02 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Date: Tue, 29 Aug 2006 18:30:25 +0200
User-Agent: KMail/1.9.1
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <1156809344.3465.41.camel@mulgrave.il.steeleye.com> <44F3A355.6090408@flower.upol.cz>
In-Reply-To: <44F3A355.6090408@flower.upol.cz>
Cc: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608291830.26033.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 04:15, Oleg Verych wrote:
> James Bottomley wrote:
> > On Tue, 2006-08-29 at 02:35 +0200, Oleg Verych wrote:
> > 
> >>request_firmware() is dead also.
> >>YMMV, but three years, and there are still big chunks of binary in kernel.
> >>And please don't add new useless info _in_ it.
> > 
> > 
> > I er don't think so.
> > 
> Hell, what can be as easy as this:
> ,-
> |modprobe $drv
> |(dd </lib/firmware/$drv.bin>/dev/blobs && echo OK) || echo Error
> `-
> where /dev/blobs is similar to /dev/port or even /dev/null char device.
> if synchronization is needed, add `echo $drv >/dev/blobs`, remove modprobe,

Please tell me how this is going to work, if we don't
know which firmware (version) is needed before be actually
initialize the device?

-- 
Greetings Michael.
