Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUG2TMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUG2TMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUG2TKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:10:15 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:32668 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263980AbUG2TIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:08:00 -0400
Date: Thu, 29 Jul 2004 21:04:01 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bart Alewijnse <scarfboy@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gigabit trouble
Message-ID: <20040729210401.A32456@electric-eye.fr.zoreil.com>
Reply-To: netdev@oss.sgi.com
References: <b71082d8040729094537e59a11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b71082d8040729094537e59a11@mail.gmail.com>; from scarfboy@gmail.com on Thu, Jul 29, 2004 at 06:45:35PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Alewijnse <scarfboy@gmail.com> :
[...]
> I run gentoo on both, which until yesterday was 2.6.7-ck5 (on both),
> and currently run 2.6.7-mm6 (again, both), as I saw the suggestion
> somewhere it had better support for the card - something about a new
> net card inferface that's nicer to interrupts.

NAPI support for r8169 is available in recent -mm kernel and there is
a small (though noticeable) optimization wrt to interrupt disabling.

[...]
> So, question one - how do I see the link speed under linux, and how,
> if at all, do I control it?

ethtool

[...]
> Disturbingly, in such a linux-to-linux speed test, my new computer
> froze.As in, in text mode, have the screen freeze and apparently be
> half written full of nonsense.

These messages would be welcome (pen/paper/serial line/image/log file
or whatever).

[...]
> So, question two - what possibly happened there?  Is this a
> driver/motherboard coincidence and therefore quite doomed?
> 
> Quite frankly, I'm stumped. Any suggestions are welcome.

Please provide:
- complete dmesg log from boot up to the point where the card can 
  trnasmit and receive (please check in your log file if the output of
  'dmesg' is truncated)
- cat /proc/interrupts once the card is up
- /sbin/lspci -vx
- /sbin/lsmod

If you have any binary module loaded, please reproduce the issue with
a kernel wherein they have not been loaded.

If you believe that it could be related to hardware, you may want to
run a complete memtest to rule out memory issues.

Reply-to: set to netdev@oss.sgi.com.

--
Ueimor
