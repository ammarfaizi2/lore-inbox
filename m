Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTLLIsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 03:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTLLIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 03:48:04 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:46212
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264510AbTLLIru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 03:47:50 -0500
From: Duncan Sands <baldrick@free.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Fri, 12 Dec 2003 09:47:48 +0100
User-Agent: KMail/1.5.4
Cc: Alan Stern <stern@rowland.harvard.edu>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org> <200312081859.03773.baldrick@free.fr> <3FD92632.50200@pacbell.net>
In-Reply-To: <3FD92632.50200@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312120947.48602.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 03:21, David Brownell wrote:
> > PS: Here is the patch that fixed the original usbfs Oops, but gained the
> > new one Vince reported:
>
> Good -- more locks vanishing from usbcore; it's about time!
> This is a case where fewer locks are better.
>
> My main patch feedback here would be that it should merge
> most of the usbfs patch I sent (second URL below).  There's
> a driver model locking requirement that you didn't know about,
> it needs to bubble up (subsys.rwsem writelock must be held if
> you're going to change driver bindings).  And there were a
> few other rough spots, which I think you've mentioned (and
> I don't think they were new issues).

Hi Dave, indeed your patch [2] and mine should go together.
I will clean mine, amalgamate with yours, and send to Greg
in logical pieces.

Duncan.
