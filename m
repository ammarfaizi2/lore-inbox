Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262220AbREXT2E>; Thu, 24 May 2001 15:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbREXT1y>; Thu, 24 May 2001 15:27:54 -0400
Received: from www.microgate.com ([216.30.46.105]:64017 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262220AbREXT1m>; Thu, 24 May 2001 15:27:42 -0400
Message-ID: <002501c0e48f$ffed1e40$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E152zbc-0005Oz-00@the-village.bc.nu>
Subject: SyncPPP Generic PPP merge
Date: Thu, 24 May 2001 14:27:48 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> I had hoped for 2.4 to use generic ppp with it. That might be the more
> productive way to attack the problem.

Generic PPP requires the user mode pppd to handle
the LCP and NCPs, while syncppp implements these in
the kernel.

Instead of using ifconfig to bring an interface
up or down, the user must now work with pppd. And the net
device naming changes (allocated by ppp_generic.c instead
of using the net device allocated by low level driver).

I have no problem with this, but some people might
not be happy with the change.

Is the plan to *replace* the PPP code in syncppp
(hopefully in a way that is invisible to the
low level drivers)?

Or is it to *add* generic PPP support to syncppp,
leaving (at least temporarily) the existing PPP 
capability in syncppp for compatibility?
(implying a new syncppp flag USE_GENERIC_PPP?)

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


