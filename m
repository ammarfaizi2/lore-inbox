Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbTIIM5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTIIM5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:57:15 -0400
Received: from maja.beep.pl ([195.245.198.10]:63760 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S264084AbTIIM5O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:57:14 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: David Brownell <david-b@pacbell.net>
Subject: Re: USB: irq 11: nobody cared!
Date: Tue, 9 Sep 2003 14:54:31 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200309072132.15278.arekm@pld-linux.org> <3F5CB08C.2040307@pacbell.net>
In-Reply-To: <3F5CB08C.2040307@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309091454.32705.arekm@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of September 2003 18:38, David Brownell wrote:
> Try changing uhci_reset() so it calls hc_reset() first,
> and then does the config space write to get rid of "legacy
> support mode".   That's the sequence it used before, which
> seems odd because it's resetting hardware that it's not yet
> responsible for.  Maybe the hc_reset() code should turn off
> that legacy mode, and do some IRQ blocking.
Unfortunately that didn't change a thing. Still I see ,,disable irq #xx'' and 
usb is not working properly here.

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

