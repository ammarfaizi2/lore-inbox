Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVHKSCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVHKSCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVHKSCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:02:30 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:42674 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932335AbVHKSC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:02:29 -0400
Message-ID: <42FB92AC.9080009@daveking.com>
Date: Thu, 11 Aug 2005 14:02:20 -0400
From: David King <dave@daveking.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pls help me understand this MCE
References: <42FB5768.8070608@daveking.com> <42FB5C4B.2010205@vc.cvut.cz>
In-Reply-To: <42FB5C4B.2010205@vc.cvut.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Try dumping *all* MCE values, as well as a call stack.  Even although
> MCE is tagged as processor context corrupt, there is rather big chance
> that stack trace will point back to the instruction which caused MCE
> (it always did in my case),  especially if it is single processor system.
> Then you'll at least know which subsystem/driver did that.

Ok, here's everything I got from the serial console when the error
occurred.  I don't have a clue how to interpret this stuff so I'd be
eternally grateful if someone out there can help.  Or, if I
misunderstood what you were telling me I ought to do, then explaining
the process a bit more would be appreciated too.

CPU 0: Machine Check Exception: 4 Bank 4: b200000000070f0f
TSC 7cba18189a
Kernel panic - not syncing: Machine check

Call Trace: <#MC> <ffffffff8013a4b5>{panic+133}
<ffffffff80116d48>{print_mce+136}
<ffffffff80116e19>{mce_panic+137} <ffffffff801173f2>{do_machine_check+754}
<ffffffff80110147>{machine_check+127}
<ffffffff80113dec>{timer_interrupt+444}
<EOE> <IRQ> <ffffffff80146b50>{process_timeout+0}
<ffffffff801704dc>{handle_IRQ_event+44} <ffffffff801706ed>{__do_IRQ+477}
<ffffffff801120b8>{do_IRQ+72} <ffffffff8010f6c3>{ret_from_intr+0}
<EOI> <ffffffff8010d230>{default_idle+0} <ffffffff8010d252>{default_idle+34}
<ffffffff8010d291>{cpu_idle+49} <ffffffff8057e7e5>{start_kernel+469}
<ffffffff8057e1f4>{_sinittext+500}

Thanks
-- 
David King
dave@daveking.com
