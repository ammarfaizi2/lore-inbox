Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267877AbUHPTAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267877AbUHPTAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUHPTAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:00:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:51119 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267889AbUHPS5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:57:51 -0400
X-Authenticated: #1725425
Date: Mon, 16 Aug 2004 21:09:49 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, jwendel10@comcast.net
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-Id: <20040816210949.3d024844.Ballarin.Marc@gmx.de>
In-Reply-To: <20040816195750.6419699f.Ballarin.Marc@gmx.de>
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
	<20040816195750.6419699f.Ballarin.Marc@gmx.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the additional commands I permit right now. It allows me to blank
a CDRW and record in TAO mode. k3b needs MODE_SELECT_10  even
for read-only access.



		safe_for_read(GPCMD_GET_CONFIGURATION),
		safe_for_read(GPCMD_GET_PERFORMANCE),
		safe_for_read(MODE_SELECT_10),

		safe_for_write(ALLOW_MEDIUM_REMOVAL),
		safe_for_write(REZERO_UNIT),
		safe_for_write(SYNCHRONIZE_CACHE),
		safe_for_write(GPCMD_SET_SPEED),
		safe_for_write(GPCMD_SEND_OPC),
		safe_for_write(GPCMD_BLANK),
		safe_for_write(GPCMD_CLOSE_TRACK),
		safe_for_write(0x5c), //whatever this might be

Shouldn't most GPCMD_* commands be safe for reading or writing, at least
for CD devices?
Are commands like MODE_SELECT_10 really safe for read?

Regards
