Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264751AbSJ3R4b>; Wed, 30 Oct 2002 12:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264757AbSJ3R4b>; Wed, 30 Oct 2002 12:56:31 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:56758 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264751AbSJ3R4a> convert rfc822-to-8bit; Wed, 30 Oct 2002 12:56:30 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: Loopback mount times out over apm suspend.
Date: Wed, 30 Oct 2002 02:46:44 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210300246.44819.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

APM suspend is a fairly impolite ting to do to an active system, but it 
reveals all sorts of funky timeouts.  (For example, Xfree86 used to exit all 
the time coming back from an APM suspend, but 4.20 finally seems to have 
gotten most of that to go away.)

I just hit a new one: a process was extracting a tarball from a loopback 
mounted zisofs system.  On return from the apm suspend, tar reported 
unexpected end of file and the mount point has mysteriously unmounted itself.

Fun datapoint for people looking at that sort of thing.  Is there some generic 
"timeout but take system suspend into account" function these sort of things 
should be using?

Standard Red Hat 8.0 kernel in this instance.  Well it's what this system 
happened to be running at the time...

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
