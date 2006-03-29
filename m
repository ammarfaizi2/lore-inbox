Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWC2WBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWC2WBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWC2WBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:01:43 -0500
Received: from mailfe08.tele2.fr ([212.247.154.236]:3545 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751014AbWC2WBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:01:42 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Thu, 30 Mar 2006 00:01:29 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, dave@mielke.cc
Subject: Re: How should an application ask for uinput module load?
Message-ID: <20060329220129.GF7158@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, dave@mielke.cc
References: <20060328194210.GD4660@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060328194210.GD4660@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Samuel Thibault, le Tue 28 Mar 2006 21:42:10 +0200, a écrit :
> what is the right way(tm) for an application to have the uinput
> module loaded, so that it can open /dev/input/uinput for emulating
> keypresses?
>
>...
> 
> I can see two approaches:
> 
> Using modprobe:
> - try to use /dev/input/uinput ; if it succeeds, fine.
> - else, if errno != ENOENT, fail
> - else, (ENOENT)
>   - try to call `cat /proc/sys/kernel/modprobe` uinput
>   - try to use /dev/input/uinput again ; if it succeeds, fine
>     - else, assume that it really wasn't compiled, and hence fail.
> 
> Triggering auto-load by creating one's own node.
> - try to use /dev/input/uinput ; if it suceeds, fine.
> - else, if errno != ENOENT, fail
> - else, (ENOENT)
>   - mknod /somewhere/safe/uinput c 10 223
>   - use /somewhere/safe/uinput ; if it succeeds, fine
>     - else, assume that it really wasn't compiled, and hence fail.
> 
> I guess the same problem arises for loop devices and all such virtual
> devices...

So? Nobody knows, or nobody cares?

Samuel
