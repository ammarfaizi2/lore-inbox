Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUHBQVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUHBQVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUHBQVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:21:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:47554 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266598AbUHBQVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:21:05 -0400
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OLS and console rearchitecture
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
	<410E55AA.8030709@ums.usu.ru> <celori$joe$1@news.cistron.nl>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I am NOT a nut....
Date: Mon, 02 Aug 2004 18:21:04 +0200
In-Reply-To: <celori$joe$1@news.cistron.nl> (Miquel van Smoorenburg's
 message of "Mon, 2 Aug 2004 16:07:14 +0000 (UTC)")
Message-ID: <je3c35qznz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miquel van Smoorenburg" <miquels@cistron.nl> writes:

> In article <410E55AA.8030709@ums.usu.ru>,
> Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
>>Jon Smirl wrote:
>>> 15) Over time user space console will be moved to a model where VT's
>>> are implemented in user space. This allows user space console access to
>>> fully accelerated drawing libraries. This might allow removal of all of
>>> the tty/vc layer code avoiding the need to fix it for SMP.
>>
>>One more minor problem. We need to ensure somehow that the "killall5" 
>>program from the sysvinit package will not kill our userspace console 
>>daemon at shutdown (got this when I tried to put fbiterm into 
>>initramfs). What is the best way to achieve that?
>
> A configuration file for killall5 in which services/daemons get
> defined that should not be signalled ?

IMHO a better solution would be some kind of process flag that can be
interrogated by killall5.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
