Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTHJJeT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTHJJeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:34:19 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:10764 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261151AbTHJJeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:34:18 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PATCH: mouse and keyboard by default if not embedded
Date: Sun, 10 Aug 2003 13:34:53 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308101334.14171.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now INPUT_MOUSEDEV_PSAUX is always (on non-embedded machines) forced to 
true,
> even on machines without PS/2 keyboard/mouse hardware. Is that OK?

> So far (compiling, not running 2.6.0-test3) I didn't notice any problems,
> though

there are problems. See

http://marc.theaimsgroup.com/?l=linux-kernel&m=106047737716122&w=2

mouse/atkbd depend on serio driver (i8042) so if i8042 is module and they are 
forced to be builtin the whole story does not work.

apparently there are people who build them as modules

-andrey
