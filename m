Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267038AbUBRBDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267058AbUBRBDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:03:36 -0500
Received: from mail.inter-page.com ([12.5.23.93]:35599 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267038AbUBRBDc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:03:32 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <tridge@samba.org>
Cc: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Al Viro'" <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Neil Brown'" <neilb@cse.unsw.edu.au>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Subject: RE: UTF-8 and case-insensitivity
Date: Tue, 17 Feb 2004 17:03:11 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAD7iWYIQ0/UO23pMD75QJewEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <Pine.LNX.4.58.0402171619010.2154@home.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P.S. Given that the GUI libraries (almost invariably) already deal with
displaying things in a case insensitive way, the "best place to cut" to add
case insensitivity to the user command-line experience would be adding a
flag to file name completion in bash.  Bash is already doing file name finds
and lookups when you press tab; and the user is actively looking at the
correctness and singularity/duality of the results.

So the proverbial "vi makef{tab}" would, if the flag was set, show you
makefile, Makefile, and MakeFile (etc) as existent or just switch makef to
"Makefile" if the name were unique.

It doesn't make lives easier for the API level project programmer people
(c.f. samba), but it could uber-happy the incoming newbies, and people like
me who have to interoperate within a vast wasteland of directories full of
inconsistently named files created by windows programmers (like SOCKET.C,
Socket.H, constants.h, and ss_switch.c all in one directory tree with
hundreds of their friends. 8-)

I would however, be forced to throttle myself with my own intestine if
kernel started doing this magic mapping "for me", especially "in some
calls/contexts but not in others".  (Not that I want to provide my possible
death as a strong motivation for adding the feature. 8-)

Rob.


