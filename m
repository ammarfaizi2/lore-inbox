Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUG0SRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUG0SRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUG0SRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:17:13 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:36998 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S266512AbUG0SRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:17:08 -0400
Date: Tue, 27 Jul 2004 14:15:20 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] kernel events layer
In-reply-to: <20040726204457.GA10970@hockin.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>,
       Robert Love <rml@ximian.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Message-id: <41069BB8.1030405@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407>
 <1090853403.1973.11.camel@localhost> <20040726161221.GC17449@kroah.com>
 <200407262013.33454.oliver@neukum.org> <20040726190305.GA19498@kroah.com>
 <20040726204457.GA10970@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Hockin wrote:
> On Mon, Jul 26, 2004 at 03:03:05PM -0400, Greg KH wrote:
>
>>>On a related note, is this supposed to supersede the current hotplug
>>>mechanism?
>>
>>No, it will not.  At the most, it will report the same information to
>>make it easier for userspace programs who want to get the other
>>event information, also get the hotplug stuff through the same
>>interface, reducing their complexity.
>>
>>So the existing hotplug interface is not going away at all.  Do not even
>>begin to think that :)
>
>
> What about flipping it around and using either hotplug or a hotplug-like
> mechanism for these events?
>
> It solves the issue of events being dropped when there is no listening
> daemon...
>
> These are not going to be high-traffic messages, right, so the overhead is
> negligible...
>

The problem with this is that you'd lose the ability to send the
messages broadcast, whereby you may have multiple dbus's listening for
events.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBpu3dQs4kOxk3/MRAthIAJ41mD9SV3tfZosw2H26Vt4xayKP5ACbB4Eb
QQImIFvK2NXCt0B5dHPj5ps=
=1TDt
-----END PGP SIGNATURE-----
