Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266563AbSKGVSb>; Thu, 7 Nov 2002 16:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266577AbSKGVSb>; Thu, 7 Nov 2002 16:18:31 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:3562 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266563AbSKGVSb>; Thu, 7 Nov 2002 16:18:31 -0500
Date: Thu, 7 Nov 2002 14:18:17 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [BK fbdev updates]
In-Reply-To: <1036312836.615.15.camel@daplas>
Message-ID: <Pine.LNX.4.33.0211071416290.3204-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Adding update_var to fbcon_switch fixes #1 and #2 for me.  Attached is a
> diff.

Patch applied :-)

> Also, using fbset to change video modes corrupts the console.  Looking
> at the code, the flow of control is from the console to fbdev only?  Is
> this correct?  I agree with this, it's saner.

Yes this is correct. In the next set of changes you will be able to set
the VC size via stty. You can change the resolution of the display via
/dev/fb but ideally after a close it will reset the VC original mode.

