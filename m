Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTDZXbD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 19:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTDZXbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 19:31:03 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:4190 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262656AbTDZXa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 19:30:59 -0400
Date: Sat, 26 Apr 2003 19:41:03 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Some code for Swap Compression
In-reply-to: <20030426160920.GC21015@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304261941030490.027ED58C@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: multipart/mixed; boundary="Boundary_(ID_5pIiGkUmxqLuzd8KTijfdw)"
References: <200304251848410590.00DEC185@smtp.comcast.net>
 <20030426091747.GD23757@wohnheim.fh-wedel.de>
 <200304261148590300.00CE9372@smtp.comcast.net>
 <20030426160920.GC21015@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_5pIiGkUmxqLuzd8KTijfdw)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

Alright, I'm done with everything except fdecomp_push() and
fcomp_push().  For the decompression function fdecomp_push(),
it fully supports the fcomp-standard streams (the ones I outlined
originally), so the fcomp-extended stuff has to be supported
(simple enough modification.  I'm lazy).  A very large portion (most
of it) of fcomp_push() needs to be coded; the entire compression
phase is uncoded.  The logic is in that function, in comments.
Someone has to read it, look at the format, and write it.  After
those two things, this can finally be shoved into a userspace
program and rewritten for the kernel, and also can be preoptimized
(i.e. don't resize the stream so many times in decompression when
it's just copying data).

tar.bz2 attatched.  Please please PLEASE make a userspace
program for this as well so that we can get a general idea about
compression ratio.  No better way than using it on files.

--Bluefox Icy

--Boundary_(ID_5pIiGkUmxqLuzd8KTijfdw)
Content-type: application/octet-stream; name=fcomp.tar.bz2
Content-transfer-encoding: x-uuencode
Content-disposition: attachment; filename=fcomp.tar.bz2

begin 755 fcomp.tar.bz2
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
68!L&L"9#0Z*&$R3^+N2*<*$AN,LN4`
`
end

--Boundary_(ID_5pIiGkUmxqLuzd8KTijfdw)--
