Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291997AbSBOAHM>; Thu, 14 Feb 2002 19:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292005AbSBOAHC>; Thu, 14 Feb 2002 19:07:02 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:25356 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S291997AbSBOAGz>; Thu, 14 Feb 2002 19:06:55 -0500
Message-ID: <3C6C5112.39EFB4DD@delusion.de>
Date: Fri, 15 Feb 2002 01:06:42 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5-pre1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Alexander Viro <viro@math.psu.edu>
Subject: init: open(/dev/console): Input/output error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Linux-2.5.5-pre1 reintroduces this old problem for me again after it had been
ok with 2.5.3-final. Some interesting information that might help track down
what's causing it.

The problem only happens when the following bit of rc.local is executed upon
startup with 2.5.5-pre1. 2.5.3 is fine.

if [ -x /opt/dnetc/dnetc ]; then
  su nobody -c /opt/dnetc/dnetc 1>/dev/tty7 2>&1 &
fi

There is no getty or anything running on tty7.

Additionally the system load as shown by w, uptime, etc. is the normal load
plus 100%. However, ps, top etc. don't show any processes causing load.

-Udo.
