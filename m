Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288902AbSAISfQ>; Wed, 9 Jan 2002 13:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288964AbSAISfG>; Wed, 9 Jan 2002 13:35:06 -0500
Received: from adsl-63-192-223-74.dsl.snfc21.pacbell.net ([63.192.223.74]:15216
	"EHLO gateway.berkeley.innomedia.com") by vger.kernel.org with ESMTP
	id <S287827AbSAISe4>; Wed, 9 Jan 2002 13:34:56 -0500
Message-ID: <3C3C8D4D.621A4696@berkeley.innomedia.com>
Date: Wed, 09 Jan 2002 10:34:53 -0800
From: Christopher James <cjames@berkeley.innomedia.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test1-rtl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multicast fails when interface changed
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id FAA13914

We are running an application that uses multicasting
on Linux kernel 2.2.19. The application is
connected to two network interfaces for redundancy
purposes - only one interface is active at a time.
When the application starts up on the first interface,
the application can send and receive multicast messages.
We then use ifconfig to bring down the first interface,
and use ifconfig to bring up the second interface. The application
works with the exception that it cannot receive multicast
packets (it can still send multicast packets).

It appears that the multicast information is not propagated
when switching from one interface to the other.  After
the switch, the information in /proc/dev/mcast is still set
up to work with the first interface.  Also, it looks like the
device list of multicast information (checked by calling
ip_check_mc()) is lost when switching from the first to
second interface.

Is there a fix or work around to keep multicasting working
when switching from one interface to another?  We looked
at the 2.4 kernel and it appears that it will have the same problem.

Also, if there is no fix or patch, we are considering whether
we should come up with a kernel patch.  If we submitted a kernel
patch that propagates the multicast information when the
interface is changed, would it be accepted into the kernel?

 I am not on the list so please CC with any answers/comments.

Thanks.

Christopher
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
