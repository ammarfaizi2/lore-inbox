Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVJETVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVJETVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVJETVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:21:40 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:261 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932542AbVJETVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:21:40 -0400
To: David Leimbach <leimy2k@gmail.com>
Cc: Bodo Eggert <7eggert@gmx.de>, Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	<3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com>
	<Pine.LNX.4.58.0510051744480.2279@be1.lrz>
	<3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: freely redistributable; void where prohibited by law.
Date: Wed, 05 Oct 2005 20:21:22 +0100
In-Reply-To: <3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com> (David
 Leimbach's message of "Wed, 5 Oct 2005 09:41:10 -0700")
Message-ID: <87zmpng47h.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, David Leimbach said:
>> 1) make namespaces joinable in a sane way
>> 2) wait for the shared subtree patch
>> 3) make pam join the per-user-namespace
>> 4) make pam automount tmpfs on the private /tmp
> 
> I'm not sure what you mean by a joinable namespace.  I also am not
> sure I want them :-).

They are namespaces which processes can join. Right now you can do
it by chrooting into /proc/{pid}/root, but this is, as Bodo said,
not a very sane API.

Without this, a user starting two sessions gets two namespaces,
which is profoundly counterintuitive from the user's POV.

> I think of namespaces as being fundamental to the process model and
> that they are inherited from the parent and new ones are created in a
> sort of COW fashion [or at least have similar behavior].

Yes, but you can change them too (that's what e.g. mount() is for!)

> You might want a session namespace instead of a joinable per-process
> namespace but I think that might be a slightly different point of
> view.

I think that's the idea; a filesystem holding namespaces that you're
allowed to chroot() into.

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
