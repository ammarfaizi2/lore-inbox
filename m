Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUHMMLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUHMMLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUHMMLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:11:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5822 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S264912AbUHMMLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:11:36 -0400
Date: Fri, 13 Aug 2004 14:11:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
In-Reply-To: <20040813110137.GY13377@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0408131312390.20634@scrub.home>
References: <20040813101717.GS13377@fs.tum.de> <Pine.LNX.4.58.0408131231480.20635@scrub.home>
 <1092394019.12729.441.camel@uganda> <Pine.LNX.4.58.0408131253000.20634@scrub.home>
 <20040813110137.GY13377@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Aug 2004, Adrian Bunk wrote:

> But the similar case of USB_STORAGE selecting SCSI is an example where 
> select is a big user-visible improvement over depends.

comment "USB storage requires SCSI"
	depends on SCSI=n

That's also user visible and doesn't confuse the user later, why he can't 
deselect SCSI.

Abusing select is really the wrong answer. What is needed is an improved 
user interface, which allows to search through the kconfig information or 
even can match hardware information to a driver and aids the user in 
selecting the required dependencies.
Keeping the kconfig database clean and making kernel configuration easier 
are really two separate problems and we shouldn't sacrifice the former for 
the latter.

bye, Roman
