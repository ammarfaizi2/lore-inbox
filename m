Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267906AbUHPTdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267906AbUHPTdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267919AbUHPTdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:33:47 -0400
Received: from fep31-0.kolumbus.fi ([193.229.0.35]:44191 "EHLO
	fep31-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S267902AbUHPTdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:33:44 -0400
Date: Mon, 16 Aug 2004 22:33:43 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Marc Ballarin <Ballarin.Marc@gmx.de>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       jwendel10@comcast.net
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
In-Reply-To: <20040816210949.3d024844.Ballarin.Marc@gmx.de>
Message-ID: <Pine.LNX.4.58.0408162226580.5241@kai.makisara.local>
References: <411FD919.9030702@comcast.net> <20040816143817.0de30197.Ballarin.Marc@gmx.de>
 <1092661385.20528.25.camel@localhost.localdomain> <20040816195750.6419699f.Ballarin.Marc@gmx.de>
 <20040816210949.3d024844.Ballarin.Marc@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Marc Ballarin wrote:

> Here are the additional commands I permit right now. It allows me to blank
> a CDRW and record in TAO mode. k3b needs MODE_SELECT_10  even
> for read-only access.
> 
> 
> 
> 		safe_for_read(GPCMD_GET_CONFIGURATION),
> 		safe_for_read(GPCMD_GET_PERFORMANCE),
> 		safe_for_read(MODE_SELECT_10),
> 
> 		safe_for_write(ALLOW_MEDIUM_REMOVAL),
> 		safe_for_write(REZERO_UNIT),
> 		safe_for_write(SYNCHRONIZE_CACHE),
> 		safe_for_write(GPCMD_SET_SPEED),
> 		safe_for_write(GPCMD_SEND_OPC),
> 		safe_for_write(GPCMD_BLANK),
> 		safe_for_write(GPCMD_CLOSE_TRACK),
> 		safe_for_write(0x5c), //whatever this might be

                Read Buffer Capacity
> 
> Shouldn't most GPCMD_* commands be safe for reading or writing, at least
> for CD devices?
> Are commands like MODE_SELECT_10 really safe for read?
> 
Mode Select is not safe enough even for write (i.e., CAP_RAWIO must be 
required). Is it really necessary for Mode Select to succeed or do the 
applications just try to do something and fail gracefully?

-- 
Kai
