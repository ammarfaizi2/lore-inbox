Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTLLPq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTLLPq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:46:58 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36881 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265269AbTLLPql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:46:41 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: 12 Dec 2003 15:35:17 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brcn7l$9oo$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org> <200312081859.03773.baldrick@free.fr> <3FD92632.50200@pacbell.net>
X-Trace: gatekeeper.tmr.com 1071243317 10008 192.168.12.62 (12 Dec 2003 15:35:17 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FD92632.50200@pacbell.net>,
David Brownell  <david-b@pacbell.net> wrote:

| The more I think about it, the more I like your idea of
| changing device->serialize to be an rwsem.  Changing config,
| or resetting the device, would get the writelock.  All other
| uses should share, with readlocks -- that's the right model.
| 
| Likely not before 2.6.1 though ... ;)

It's not clear one way or the other, since there is an oops involved it
seems a bugfix is in order. It chould be fixed, perhaps the change
described above could be accepted, since it's clearly a bugfix for a
serious problem.

Not our choice, but arguable...
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
