Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUACQh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 11:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUACQh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 11:37:56 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:64139 "HELO
	develer.com") by vger.kernel.org with SMTP id S263592AbUACQhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 11:37:55 -0500
Message-ID: <3FF6EFE0.9030109@develer.com>
Date: Sat, 03 Jan 2004 17:37:52 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: vojtech@suse.cz
CC: lkml <linux-kernel@vger.kernel.org>
Subject: bad scancode for USB keyboard
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a USB keyboard (Logitech Internet Navigator).
This keyboard has two "backslash + bar" keys, one of which
is located next to the RETURN key.

The backslash key always worked fine in 2.4.x, but in 2.6.x
and 2.6.0, the scancode reported by showkey is "84", which is
usually associated with the "Prevconsole" function in most
keymaps.

Editing the keymap fixes the problem, but of course this must
be a bug in the kernel driver.  I compared the 2.4.23 version
of kbdmap.c with 2.6.0, but didn't find any obvious reason for
this difference.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/


