Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSLMRvh>; Fri, 13 Dec 2002 12:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSLMRvh>; Fri, 13 Dec 2002 12:51:37 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:8658 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262023AbSLMRvg> convert rfc822-to-8bit; Fri, 13 Dec 2002 12:51:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-BK] Fix typo in arch/arm/config.in
Date: Fri, 13 Dec 2002 18:59:16 +0100
User-Agent: KMail/1.4.3
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200212131844.45280.m.c.p@wolk-project.de>
In-Reply-To: <200212131844.45280.m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212131859.16039.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 December 2002 18:47, Marc-Christian Petersen wrote:

Hi again,

> this fixes a typo in arch/arm/config.in.
> old:    source drivers/ssi/Config.in
> new:	source drivers/scsi/Config.in
>  Without it, make menuconfig crashes.
ignore this patch. It is wrong.

So we have this:

if [ "$CONFIG_SCSI" != "n" ]; then
   source drivers/scsi/Config.in
fi     
endmenu

if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then 
   source drivers/ssi/Config.in 
fi

drivers/ssi/Config.in does not exist, make menuconfig crashes.
I thought it is a typo, but source'ing it twice also crashes, for sure.

So what is drivers/ssi/* ?

Or should this be drivers/sgi/Config.in ?

ciao, Marc
