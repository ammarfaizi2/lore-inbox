Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267014AbUBROFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUBROFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:05:18 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:11980 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S267014AbUBROFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:05:12 -0500
Message-ID: <4033714A.FFFEBD6C@users.sourceforge.net>
Date: Wed, 18 Feb 2004 16:06:02 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net>
		 <m265e9oyrs.fsf@tnuctip.rychter.com>
		 <402F877C.C9B693C1@users.sourceforge.net>
		 <m2k72n9pth.fsf@tnuctip.rychter.com>
		 <40322094.83061A32@users.sourceforge.net> <m24qtpikmd.fsf@tnuctip.rychter.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Rychter wrote:
>  Jari> Do you mind doing a a quick grep:
> 
>  Jari> cd /path/to/your/kernel/source grep "Jari Ruusu"
>  Jari> drivers/block/loop.c
> 
>  Jari> If you see my name there, your kerneli.org cryptoapi enabled
>  Jari> kernel is running same loop code I wrote years ago. Those
>  Jari> loop-jari-something patches that you find on the net, are just
>  Jari> copies of old loop-AES code.
> 
> No, it is not running this code. The code that works well for me is the
> external cryptoapi (as modules) with last update in Feb 2002.

Then you are running loop that fails in few seconds using my tests.

> How do you get a file-backed encrypted filesystem to work under Linux
> 2.4.24?

Writable file backed loops received death sentence when GFP_NOFS was
introduced to kernel, and they have been on death row since then. The best
way is to set up partition backed loop using loop-AES. Mainline loop is
still prone to deadlock, both file backed and device backed.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
