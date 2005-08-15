Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVHOAJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVHOAJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVHOAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 20:09:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51134 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932582AbVHOAJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 20:09:50 -0400
Subject: Re: IDE CD problems in 2.6.13rc6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Voluspa <voluspa@telia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050815005101.26df083a.voluspa@telia.com>
References: <20050815005101.26df083a.voluspa@telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Aug 2005 01:37:08 +0100
Message-Id: <1124066229.29265.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-15 at 00:51 +0200, Voluspa wrote:
> hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdc: drive_cmd: error=0x04 { AbortedCommand }
> ide: failed opcode was: 0xec
> ide: Did you just run "hdparm -I" or do you use a nosy desktop?

We certainly could interpret 0x51, 0x04 specifically. Its not an "error"
in the usual spew at the user case generally speaking but a "do this"
"no" sequence. Its useful to log because sending unknown commands to an
IDE device is something we want to catch (some drives hang if you do it,
others do really *crazy* things).

Would

hdc: command not supported by drive
ide: failed opcode was: 0xec

have been more helpful 

Alan

