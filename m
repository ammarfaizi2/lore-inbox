Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264620AbTEQAOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTEQAOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 20:14:44 -0400
Received: from mail.gmx.de ([213.165.65.60]:65173 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264620AbTEQAOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 20:14:43 -0400
Message-ID: <3EC581F0.8070908@gmx.net>
Date: Sat, 17 May 2003 02:27:28 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       davej@suse.de
Subject: Re: 2.5.69-mm6: pccard oops while booting
References: <1053004615.586.2.camel@teapot.felipe-alfaro.com> <20030515144439.A31491@flint.arm.linux.org.uk> <1053037915.569.2.camel@teapot.felipe-alfaro.com> <20030515160015.5dfea63f.akpm@digeo.com> <1053090184.653.0.camel@teapot.felipe-alfaro.com> <1053110098.648.1.camel@teapot.felipe-alfaro.com> <20030516132908.62e54266.akpm@digeo.com> <1053121346.569.1.camel@teapot.felipe-alfaro.com> <3EC56173.1000306@gmx.net> <1053128425.607.1.camel@teapot.felipe-alfaro.com> <20030517005538.D26797@flint.arm.linux.org.uk>
In-Reply-To: <20030517005538.D26797@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, May 17, 2003 at 01:40:26AM +0200, Felipe Alfaro Solana wrote:
> 
>>This is getting tricky. How about this one?
>>Attached is "ymfpci2.patch" with your suggested changes, and "dmesg"
>>with the new oops info.
> 
> 
> You need to reproduce the oops you get when you modprobe the module.
> The oops with this driver built in is different, and akpm's changes
> won't tell us which one causes the problem.

True. Just a stab in the dark - leaving KOBJ_NAME_LEN == 20 and
initializing the first four and last four bytes of the KOBJ_NAME_LEN
sized buffer with a counter starting at 0 might also prove very
interesting and could help resolve the Oops with the driver built in.
Motivation: Somehow, the disaster smells like somebody uses a hardcoded
offset designed to work only if KOBJ_NAME_LEN == 16.

I would provide a patch, but I don't have the source handy right now due
to disk space constraints.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

