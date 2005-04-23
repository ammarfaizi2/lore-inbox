Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVDWTGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVDWTGB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVDWTGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 15:06:01 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:58623 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261703AbVDWTFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 15:05:51 -0400
Message-ID: <2911.10.10.10.24.1114279589.squirrel@linux1>
Date: Sat, 23 Apr 2005 14:06:29 -0400 (EDT)
Subject: Re: Git-commits mailing list feed.
From: "Sean" <seanlkml@sympatico.ca>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Thomas Glanzmann" <sithglan@stud.uni-erlangen.de>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Jan Dittmer" <jdittmer@ppp0.net>, "Greg KH" <greg@kroah.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Git Mailing List" <git@vger.kernel.org>
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>   
    <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>   
    <426A4669.7080500@ppp0.net>   
    <1114266083.3419.40.camel@localhost.localdomain>   
    <426A5BFC.1020507@ppp0.net>   
    <1114266907.3419.43.camel@localhost.localdomain>   
    <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>   
    <20050423175422.GA7100@cip.informatik.uni-erlangen.de>   
    <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, April 23, 2005 2:30 pm, Linus Torvalds said:
> On Sat, 23 Apr 2005, Thomas Glanzmann wrote:
>> # This creates the signature.
>> gpg --clearsign < sign_this > signature
>
> This really doesn't work for me - I do not want to have the gpg header
above it, only the signature below. Since I want git to actually
understand the tags, but do _not_ want git to have to know about
whatever
> signing method was used, I really want the resulting file to look like
>
> 	commit ....
> 	tag ...
>
> 	here goes comment
> 	here goes signature
>
> and no headers.
>
> Whether that can be faked by always forcing SHA1 as the hash, and then
just removing the top lines, and re-inserting them when verifying, or
whether there is some mode to make gpg not do the header crud at all, I
don't know. Which is exactly why I never even got started.

Linus,

A script that knows how to validate signed tags, can easly strip off all
the signing overhead for display.   Users of scripts that don't understand
will see the cruft, but at least it will still be usable.

Sean


