Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTDVPfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTDVPfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:35:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26846
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263206AbTDVPfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:35:14 -0400
Subject: Re: [PATCH] M68k IDE updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0304211833010.14857-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0304211833010.14857-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051022954.15160.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 15:49:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-21 at 17:55, Geert Uytterhoeven wrote:
> However, there's also a routine that involves more magic:
> taskfile_lib_get_identify(). While trying to understand that one, I found more
> commands that should call the (possible byteswapping) hwif->ata_input_id()
> operations, like SMART commands. So first we need a clearer differentiation
> between commands that transfer on-platter data, or other drive data.
> 
> Any comments from the IDE experts?

Only one, stop abusing the IDE layer and do your byte swapping via a loopback/md 
or similar piece of code. 

