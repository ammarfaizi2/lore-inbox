Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbTGIKWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbTGIKWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:22:51 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:46329 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S268153AbTGIKV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:21:28 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined
 patch
X-URL: <http://www.linux-mandrake.com/
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru>
	<200307072306.15995.arvidjaar@mail.ru>
	<20030707140010.4268159f.akpm@osdl.org>
	<200307082149.17918.arvidjaar@mail.ru>
	<20030709012014.GA19777@www.13thfloor.at>
	<20030708182620.590edd06.akpm@osdl.org>
	<20030709020943.GA25422@www.13thfloor.at>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: MandrakeSoft
Date: Wed, 09 Jul 2003 12:34:55 +0200
In-Reply-To: <20030709020943.GA25422@www.13thfloor.at> (Herbert Poetzl's
 message of "Wed, 9 Jul 2003 04:09:43 +0200")
Message-ID: <m2vfucng34.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> the group using devfs, usually doesn't care about
> the 'compatibility' issue,

i disagree: distro vendors wants that compatibility.
we want both the features of devfsd+hotplug+dynamic and the
compatibility devices.

> > I'm hoping that smalldevfs comes back.  
> > The current thing is a running sore.
> 
> I'm hoping too, and I would like to see it on 2.6 as well as 2.4 ...

there's been quite some cleanups on the 2.5.x side.
maybe can we complete this work before thinking about a new system ?
(remember the kbuild2 destiny ...)

if we do not want to create a compatibility layer such as devfsd for
smalldevfs, we can still alter drivers to create /dev/hda3 instead of
/dev/ide/host0/bus0/target0/lun0/part3 and the like

withouth any compatibility, smalldevfs will be a pain in th *ss for
distro vendors.

