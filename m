Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbRE2Q7K>; Tue, 29 May 2001 12:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbRE2Q7B>; Tue, 29 May 2001 12:59:01 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261302AbRE2Q6u>;
	Tue, 29 May 2001 12:58:50 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: select() - Linux vs. BSD
Date: Tue, 29 May 2001 11:55:24 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGKEIICHAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I hope I'm not rehashing anything discussed before, but I couldn't find any
references to this:

	In BSD, select() states that when a time out occurs, the bits passed to
select will not be altered.  In Linux, which claims BSD compliancy for this
in the man page (but does not state either way what will happen to the
bits), zeros the users bit masks when a timeout occurs.  I have written a
test case, and run on both systems; BSD behaves as stated, Linux does not
act like BSD.

	Should the man pages be changed to reflect reality, or select() fixed to
act like BSD?

	-- John

