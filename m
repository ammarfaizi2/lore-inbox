Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUDFDRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 23:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUDFDRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 23:17:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:61923 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263607AbUDFDRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 23:17:20 -0400
Date: Mon, 5 Apr 2004 20:10:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New compiler warning: 2.6.4->2.6.5
Message-Id: <20040405201052.2be56c2e.rddunlap@osdl.org>
In-Reply-To: <1081220649.13965.15.camel@lightning>
References: <1081220649.13965.15.camel@lightning>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Apr 2004 20:04:09 -0700 John Cherry <cherry@osdl.org> wrote:

| 9 new compiler warnings between 2.6.4 and 2.6.5.
| 
| gcc: 3.2.2
| arch: i386
| 
| drivers/acpi/events/evmisc.c:143: warning: too many arguments for format
| drivers/char/applicom.c:523:2: warning: #warning "Je suis stupide. DW. -
| copy*user in cli"
| drivers/char/watchdog/cpu5wdt.c:305: warning: initialization discards
| qualifiers from pointer target type
| drivers/char/watchdog/cpu5wdt.c:305: warning: return discards qualifiers
| from pointer target type
| drivers/media/dvb/frontends/tda1004x.c:191: warning: `errno' defined but
| not used
| drivers/pcmcia/i82365.c:71: warning: `version' defined but not used
| drivers/pcmcia/tcic.c:64: warning: `version' defined but not used
| sound/isa/wavefront/wavefront_synth.c:1923: warning: `errno' defined but
| not used
| sound/oss/wavfront.c:2498: warning: `errno' defined but not used

hi john,

i didn't check all of these, but the #warning in applicom.c
(Je suis stupide.) has been around forever and it's listed in
both your 2.6.4 and 2.6.5 warning logs:

http://developer.osdl.org/cherry/compile/2.6/linux-2.6.4.results/2.6.4.allmodconfig.modules.txt:
drivers/char/applicom.c:522:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"

and
http://developer.osdl.org/cherry/compile/2.6/linux-2.6.5.results/2.6.5.allmodconfig.modules.txt:
drivers/char/applicom.c:523:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"

Ooh, was it the line number change that made it look new???

--
~Randy
