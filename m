Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTAKPJ0>; Sat, 11 Jan 2003 10:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTAKPJ0>; Sat, 11 Jan 2003 10:09:26 -0500
Received: from gherkin.frus.com ([192.158.254.49]:1152 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267245AbTAKPJZ>;
	Sat, 11 Jan 2003 10:09:25 -0500
Subject: 2.5.55+: soundcore: Unknown symbol errno
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Jan 2003 09:18:12 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030111151812.3F4DC4EE7@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the subject error message with ALSA for both 2.5.55 and
2.5.56.  The culprit appears to be the very last patch in the 2.5.55
patch set, which deletes "static int errno;" from
linux/sound/sound_firmware.c.  The undefined reference to errno is
from the include of <linux/unistd.h>.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
