Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTEGI1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 04:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTEGI1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 04:27:54 -0400
Received: from mail.convergence.de ([212.84.236.4]:58780 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262974AbTEGI1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 04:27:53 -0400
Message-ID: <3EB8C67A.4020500@convergence.de>
Date: Wed, 07 May 2003 10:40:26 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
References: <3EB7DCF0.2070207@convergence.de> <20030506220828.A19971@infradead.org>
In-Reply-To: <20030506220828.A19971@infradead.org>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

> What the problem with 2.5, dvb and devfs? 

The main problem is that our development "dvb-kernel" CVS tree *should* 
compile under 2.4 aswell, because most of the dvb-users don't want to 
participate in kernel development in general, but only on the 
development of the dvb subsystem. So work is done on the "dvb-kernel" 
tree, which should be synced with the 2.5 kernel frequently.

So, regarding devfs, I introduced #ifdefs around the functions that have 
changed recently. That's not nice, I know. But in my eyes it's important 
to keep the CVS and the kernel version more in sync.

IIRC Gerd Knorr has the same problems with his driver packages 
(regarding the i2c subsystem mainly), but he has written some perl 
scripts to remove the #ifdef stuff before submitting his patches...

> I already told one of the DVB folks
> (it wasn't you IIRC) that I'll publish a 2.5 devfs API on 2.4 header.

No, you spoke to Holger I think, who has maintained the dvb-core kernel 
submissions before me.

> But first I have to fix the devfs API on 2.5 and randomly bringing
> back old crap and lots of ifdefs in those changing areas won't help.

I understand. But delaying the dvb updates just because a few calls to 
the devfs subsystem (which are now separated by #ifdefs and can easily 
be found) is not a good option either, or is it?

CU
Michael.

