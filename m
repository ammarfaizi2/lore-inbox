Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVAUTDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVAUTDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVAUTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:03:38 -0500
Received: from pop-a065c32.pas.sa.earthlink.net ([207.217.121.247]:3232 "EHLO
	pop-a065c32.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262465AbVAUTDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:03:23 -0500
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: system load avg loops?!?
Date: Fri, 21 Jan 2005 13:04:34 -0600
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <18D4A39C-6BCA-11D9-9476-000D932A43BC@karlsbakk.net>
In-Reply-To: <18D4A39C-6BCA-11D9-9476-000D932A43BC@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501211304.34556.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 10:32 am, Roy Sigurd Karlsbakk wrote:
This is not re-creatable here. As expected the tight loop pegs my CPU to 100 
and we see the load avg increasing.

Either this was introduced in mm1, gentoo fixes it, or its an isolated 
incident with Mr R. Karlsbakk.

Can I be of service in any other capacity kernel gurus?

bot403@eric MVS $ uname -a
Linux eric 2.6.9-gentoo-r9 #6 Wed Jan 19 18:37:07 CST 2005 i686 AMD Athlon(tm) 
XP 2600+ AuthenticAMD GNU/Linux

--------------Tried to recreate OP output below------------
<~:12:55:44>
root@eric >while true; do uptime >> log; done
<~:12:57:37>
root@eric >uniq log
 12:55:45 up 1 day, 18:14,  7 users,  load average: 0.69, 0.55, 0.38
 12:55:46 up 1 day, 18:14,  7 users,  load average: 0.69, 0.55, 0.38
 12:55:47 up 1 day, 18:14,  7 users,  load average: 0.69, 0.55, 0.38
 12:55:48 up 1 day, 18:14,  7 users,  load average: 0.69, 0.55, 0.38
 12:55:48 up 1 day, 18:14,  7 users,  load average: 0.87, 0.59, 0.39
 12:55:49 up 1 day, 18:14,  7 users,  load average: 0.87, 0.59, 0.39
 12:55:50 up 1 day, 18:14,  7 users,  load average: 0.87, 0.59, 0.39
 12:55:51 up 1 day, 18:14,  7 users,  load average: 0.87, 0.59, 0.39
 12:55:52 up 1 day, 18:14,  7 users,  load average: 0.87, 0.59, 0.39
 12:55:53 up 1 day, 18:14,  7 users,  load average: 0.87, 0.59, 0.39
 12:55:53 up 1 day, 18:14,  7 users,  load average: 0.88, 0.60, 0.39
 12:55:54 up 1 day, 18:14,  7 users,  load average: 0.88, 0.60, 0.39
 12:55:55 up 1 day, 18:14,  7 users,  load average: 0.88, 0.60, 0.39
 12:55:56 up 1 day, 18:14,  7 users,  load average: 0.88, 0.60, 0.39
 12:55:57 up 1 day, 18:14,  7 users,  load average: 0.88, 0.60, 0.39
 12:55:58 up 1 day, 18:14,  7 users,  load average: 0.88, 0.60, 0.39
--snip to shorten, you get the idea steady increase--
 12:56:55 up 1 day, 18:15,  7 users,  load average: 0.95, 0.67, 0.43
 12:56:56 up 1 day, 18:15,  7 users,  load average: 0.95, 0.67, 0.43
 12:56:57 up 1 day, 18:15,  7 users,  load average: 0.95, 0.67, 0.43
 12:56:58 up 1 day, 18:15,  7 users,  load average: 0.95, 0.67, 0.43
 12:56:58 up 1 day, 18:15,  7 users,  load average: 0.96, 0.67, 0.43
 12:56:59 up 1 day, 18:15,  7 users,  load average: 0.96, 0.67, 0.43
--snip more avg .96 each second--
 12:57:12 up 1 day, 18:15,  7 users,  load average: 0.96, 0.68, 0.44
 12:57:13 up 1 day, 18:15,  7 users,  load average: 0.96, 0.68, 0.44
 12:57:13 up 1 day, 18:15,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:14 up 1 day, 18:15,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:15 up 1 day, 18:15,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:16 up 1 day, 18:15,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:16 up 1 day, 18:16,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:17 up 1 day, 18:16,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:18 up 1 day, 18:16,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:19 up 1 day, 18:16,  7 users,  load average: 0.97, 0.69, 0.44
 12:57:20 up 1 day, 18:16,  7 users,  load average: 0.97, 0.69, 0.44
<~:12:57:40>
root@eric >                                         

> hei
>
> the log at http://karlsbakk.net/uptime.log.gz is a log create with
--snip--

-- 
----------------------------------------
--EB

> All is fine except that I can reliably "oops" it simply by trying to read
> from /proc/apm (e.g. cat /proc/apm).
> oops output and ksymoops-2.3.4 output is attached.
> Is there anything else I can contribute?

The latitude and longtitude of the bios writers current position, and
a ballistic missile.

                --Alan Cox LKML-December 08,2000 

----------------------------------------
