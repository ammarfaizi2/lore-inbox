Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131337AbRAABfg>; Sun, 31 Dec 2000 20:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131332AbRAABfQ>; Sun, 31 Dec 2000 20:35:16 -0500
Received: from isis.telemach.net ([213.143.65.10]:3339 "HELO isis.telemach.net")
	by vger.kernel.org with SMTP id <S131197AbRAABfK>;
	Sun, 31 Dec 2000 20:35:10 -0500
Message-ID: <3A4FD789.EF4C6125@telemach.net>
Date: Mon, 01 Jan 2001 02:04:09 +0100
From: Jure Pecar <pegasus@telemach.net>
Organization: Select Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: andrea@suse.de, jef@acme.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?) 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I can't manage to reproduce the problem on my home box, based on redhat7
... thttpd runs ok on 2.2.18 with raid patch, 2.2.18-cdhs
(www.linuxraid.org) and 2.2.19pre3aa4 ... I tought it might be some
compiler/glibc problem, but even if i get a kernel and a statically
compiled thttpd from the box that is making problems(rh6.0) and run it
here, it runs ok ... 
What more can i try? I'd really like to find out what's going on ... 

I checked those bits Alan Cox mentioned and cdhs patch puts them like
this (include/linux/fs.h btw):

#define BH_LowPrio      7       /* 1 if the buffer is lowprio */
#define BH_Wait_IO      8       /* 1 if we should throttle on this
buffer */

Andrea, in your pre3aa4 patch you put them vice versa:

#define BH_Wait_IO      7       /* 1 if we should throttle on this
buffer */
#define BH_LowPrio      8       /* 1 if the buffer is lowprio */

I dont think this really matters, but which way should be official? :)

and btw, happy new year to all of you.

-- 


Pegasus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
