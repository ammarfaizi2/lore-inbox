Return-Path: <linux-kernel-owner+willy=40w.ods.org-S286987AbUKASbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S286987AbUKASbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S280158AbUKARa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:30:56 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54474 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S268361AbUKAR17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:27:59 -0500
Date: Mon, 1 Nov 2004 18:27:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fchown on unix domain sockets?
In-Reply-To: <200411011543.04881.jmc@xisl.com>
Message-ID: <Pine.LNX.4.53.0411011825010.5419@yvahk01.tjqt.qr>
References: <200410312255.00621.jmc@xisl.com> <200411011441.56524.jmc@xisl.com>
 <Pine.LNX.4.53.0411011546050.30106@yvahk01.tjqt.qr> <200411011543.04881.jmc@xisl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >When I connect to it is the point. I want to set the permissions etc so
>> > that only the progams that are supposed to be talking to it talk to it.
>>
>> How about setting the permissions beforehand?
>
>We're talking about fchown not fchmod. Obviously you can set "umask" so that
>the appropriate permissions are on or off.

Whoops. Well, you said "permissions" in the topmost quoted thing.
Anyway, you could use ACLs to restrict connecting to a PF_UNIX
socket on a per user/group basis.

>I just thought it would be worth drawing attention to the fact that "fchown"
>silently does nothing and the whole thing is not documented anywhere (even on
>OSes which give an error code). It just seemed a gap worth plugging.

Now the message is clear. Glibc info pages maintained by
glibc-bugs@gnu.org (IIRC), man pages now maintained by (sorry forgot
the addr, but take a look on LKML archive for this day).


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
