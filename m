Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbRBMKaE>; Tue, 13 Feb 2001 05:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbRBMK3p>; Tue, 13 Feb 2001 05:29:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:34314 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129414AbRBMK3o>; Tue, 13 Feb 2001 05:29:44 -0500
Date: Tue, 13 Feb 2001 05:30:09 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Sven Koch <haegar@sdinet.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: lkml subject line
In-Reply-To: <Pine.LNX.4.32.0102131107400.21378-100000@space.comunit.de>
Message-ID: <Pine.LNX.4.33.0102130528200.8874-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Sven Koch wrote:

>> That said, and while we're on the topic.. Does anyone have a
>> *PERFECT* recipe for procmail to REMOVE the stupid [Dummy] things
>> most GNU mailman lists and others prepend to the subject?
>
>I am using the following to sort the suse-security-list (for example, I do
>the same on all lists that tag something into the subject):
>
>:0 fhw
>* ^TO_suse-security@suse.com
>| sed -e '/^Subject:/s/\[suse-security\] //'
>:0 A:
>SuSE-Security$MONTH

DAMN!  I was _SO_ close!  I'm no sed expert, but I have been
working the last hour or so on nailing this down and here is what
I had:

:0:
* ^Subject:.*testxpert
{
    :0 fWh
    * ^Subject:.*\[Xpert\]
    | sed -e '/^Subject:/ s/\[Xpert\]//g' >> XPERT
}

Didn't work of course, but I got the sed line right by the looks
of it.  Should ever we meet, I'm buying the beer good man!


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
Need general help or technical support with Red Hat Linux 7.0?  Join the user 
support mailing list by sending a message to "guinness-list-request@redhat.com"
with the word "subscribe" on the subject line.

