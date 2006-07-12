Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWGLWHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWGLWHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWGLWHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:07:20 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:53176 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932464AbWGLWHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:07:19 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
To: Paulo Marques <pmarques@grupopie.com>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 13 Jul 2006 00:06:37 +0200
References: <6wOHw-5gl-23@gated-at.bofh.it> <6x0yX-5An-17@gated-at.bofh.it> <6xc78-6gi-15@gated-at.bofh.it> <6xyhf-5Fq-1@gated-at.bofh.it> <6xyU6-6Hn-63@gated-at.bofh.it> <6xzdl-75B-13@gated-at.bofh.it> <6xzZO-8gU-23@gated-at.bofh.it> <6xA9p-8ti-7@gated-at.bofh.it> <6xACo-Op-1@gated-at.bofh.it> <6xAVM-1b9-5@gated-at.bofh.it> <6xBfh-1yd-29@gated-at.bofh.it> <6xBRQ-2v4-3@gated-at.bofh.it> <6xITm-4td-17@gated-at.bofh.it> <6xMX0-2bX-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G0mrB-0001JL-T3@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> wrote:
> Roman Zippel wrote:
>> On Tue, 11 Jul 2006, Andrew Morton wrote:
>> [...]
>>> What, actually, is the problem?
>> 
>> It changes the behaviour, it will annoy the hell out of people like me who
>> have to deal with different kernels and expect this to just work. :-(
>> Since then has it been acceptable to just go ahead and break stuff? This
>> problem doesn't really look unsolvable, so why is my request to fix the
>> damn thing so unreasonable?
> 
> Ok, what about this one?
> 
> I don't have time to test it (it compiles, at least), but it seems the
> logic is pretty clear: once you have pressed both "Alt" and "SysRq"
> sysrq mode becomes active until you release *both* keys. In this mode
> any regular key press triggers handle_sysrq.
> 
> This allows for all the combinations mentioned before in this thread and
> makes the logic simpler, IMHO.

Why don't you use a bitmask?
alt-sysrq down -> val  =  0b11
sysrq up       -> val &= ~0b01
alt up         -> val &= ~0b10

test is_sysrq == !!val
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
