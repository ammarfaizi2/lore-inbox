Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWAJJBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWAJJBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWAJJBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:01:43 -0500
Received: from webmailv3.ispgateway.de ([80.67.16.113]:905 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750964AbWAJJBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:01:42 -0500
Message-ID: <1136883693.43c377ed83361@www.domainfactory-webmail.de>
Date: Tue, 10 Jan 2006 10:01:33 +0100
From: Clemens Ladisch <clemens@ladisch.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: ALSA - pnp OS bios option
References: <200601092022.56244.nick@linicks.net>
In-Reply-To: <200601092022.56244.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> 00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
>
> If I turn OFF PNP OS, when I boot, 'alsactl restore' (run from
> rc.local) squinnies:
>
> Set_Control:894 Name mismatch ... Control #47
> 896: Index mismatch (0/0) for Control #47
> 1008: Bad control.47.value

This usually happens when you use a different driver version that has
different mixer controls so that the saved state in /etc/asound.state
doesn't match.

I don't know why the "PNP OS" setting should affect which mixer
controls are available.  What are the differences in /etc/asound.state
after "alsactl store" in both cases?


Clemens

