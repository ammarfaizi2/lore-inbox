Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTDGPDT (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTDGPDT (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:03:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61332
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263507AbTDGPDS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 11:03:18 -0400
Subject: Re: modifying line state manually on ttyS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304071702.08114.freesoftwaredeveloper@web.de>
References: <200304071702.08114.freesoftwaredeveloper@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049724987.2965.60.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 15:16:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 16:02, Michael Buesch wrote:
> I have developed my own device, that is connected to ttyS0.
> To talk to my device, I need to set the state of the TxD line
> manually to either 0 or 1 (+12v or -12v). What I try to say is,

TxD is a bad choice. A lot of the hardware cannot control TXD this
way. DTR is the usual one because it is easy to handle but there
are other control lines you can drive directly (see TIOCGMODEM)


