Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVGFTaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVGFTaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVGFT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:28:37 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:45833 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262163AbVGFOK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:10:56 -0400
Message-ID: <42CBE67D.9000507@slaphack.com>
Date: Wed, 06 Jul 2005 09:11:09 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Ulrich <reiser4@blinkenlights.ch>
Cc: reiser@namesys.com, hubert@uhoreg.ca, agmsmith@rogers.com,
       ross.biro@gmail.com, vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com,
       Valdis.Kletnieks@vt.edu, ltd@cisco.com, gmaxwell@gmail.com,
       jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com>	<1740726161-BeMail@cr593174-a>	<87hdf8zqca.fsf@evinrude.uhoreg.ca>	<42CB7DE0.4050200@namesys.com>	<42CBD7F6.2050203@slaphack.com> <20050706154349.5d6aa92c.reiser4@blinkenlights.ch>
In-Reply-To: <20050706154349.5d6aa92c.reiser4@blinkenlights.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Ulrich wrote:
>>so all we have left is the issue of whether using /meta costs us 
>>performance, or whether breaking POSIX to add a symlink (such as 
>>foo/...) really gives us that much more usability.
> 
> 
> IMHO '/meta' isn't such a good idea, because a chrooted application
> won't be able to use it.

mount --bind.  Is there a performance hit for having too many of those?

mount --bind /meta/vfs/some/chroot /some/chroot/meta

Also, maybe a separately-mounted /meta, maybe with something like
'-o root='

I can't think of when you'd have a chrooted application that uses /meta, 
but wasn't written with /meta in mind, so as to have these mount 
commands in its init scripts.

