Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131331AbRCWTMb>; Fri, 23 Mar 2001 14:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCWTMV>; Fri, 23 Mar 2001 14:12:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:7684 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S131331AbRCWTMP>;
	Fri, 23 Mar 2001 14:12:15 -0500
Message-ID: <3ABB9CF2.E7715667@evision-ventures.com>
Date: Fri, 23 Mar 2001 19:58:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gVQf-00056B-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a constructive proposal:

It would make much sense to make the oom killer
leave not just root processes alone but processes belonging to a UID
lower
then a certain value as well (500). This would be:

1. Easly managable by the admin. Just let oracle/www and analogous users
   have a UID lower then let's say 500.

2. In full compliance with the port trick done by TCP/IP (ports < 1024
vers other)

3. It wouldn't need any addition of new interface (no jebanoje gawno in
/proc in addition()

4. Really simple to implement/document understand.

5. Be the same way as Solaris does similiar things.

...


Damn: I will let my chess club alone toady and will just code it down
NOW.

Spec:

1. Processes with a UID < 100 are immune to OOM killers.
2. Processes with a UID >= 100 && < 500 are hard for the OOM killer to
take on.
3. Processes with a UID >= 500 are easy targets.

Let me introduce a new terminology in full analogy to "fire walls"
routers and therabouts:

Processes of category 1. are called captains (oficerzy)
Processes of category 2. are called corporals (porucznicy)
Processes of category 2. are called privates (¿o³nierze)

;-)
