Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVCOOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVCOOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVCOOZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:25:58 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:60144 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261261AbVCOOZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:25:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bMscOwvcyDuIIAiaUe4OzBzPXTl4mlyBlU3sRV1ClAevsa83FeRZPEOlqidtNYPaqEUWHBHjZyBDSRzHaq/yLMkOfjW8J70xqBIpvt19xQzGRmhpWNqsSUCeJCOjRdRjnAy+IJD1ELWoABJasisq7sBNSquLcS7YTy86qT/JduQ=
Message-ID: <d120d50005031506252c64b5d2@mail.gmail.com>
Date: Tue, 15 Mar 2005 09:25:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.11-mm3 mouse oddity
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <4236D428.4080403@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <4236D428.4080403@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 13:25:12 +0100, Helge Hafting
<helge.hafting@aitel.hist.no> wrote:
> 2.6.11-mm1 and earlier: mouse appear as /dev/input/mouse0
> 2.6.11-mm3: mouse appear as /dev/input/mouse1
> 
> No big problem, one change to xorg.conf and I got the mouse back.
> I guess it wasn't supposed to change like that though?
>

Vojtech activated scroll handling in keyboard code by default so now
your keyboard is mapped to the mouse0 and the mouse moved to mouse1.

Vojtech, is is possible to detect whether a keyboard has scroll
wheel(s) by its ID?

> This is a mouse connected to the ps2 port, also appearing as /dev/psaux
> 

I'd recommend using /dev/input/mice unless you want to _exclude_ some
of your input devices. It will get data from all you mice at once and
is always available.

-- 
Dmitry
