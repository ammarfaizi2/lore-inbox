Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbRAJQ2c>; Wed, 10 Jan 2001 11:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130886AbRAJQ2W>; Wed, 10 Jan 2001 11:28:22 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:51725 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130026AbRAJQ2J> convert rfc822-to-8bit; Wed, 10 Jan 2001 11:28:09 -0500
Message-ID: <3A5C8D2F.79D0A9A5@aixigo.de>
Date: Wed, 10 Jan 2001 17:26:23 +0100
From: Tobias Haustein <T.Haustein@aixigo.de>
Organization: aixigo AG
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel shouldn't wait for any key in case of error
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I found that the kernel (checked on 2.2.16 and 2.2.17) contains at least
two calls to wait_for_keypress (in drivers/block/rd.c and fs/super.c).
This is very annoying if you're running a server farm that is located in
another building.

I'd propose a configuration option that allows a user to decide whether
the kernel is allowed to wait for "any key". Another solution would be
to provide a timeout.


Ciao,

Tobias Haustein

--
Dipl. Inform. Tobias Haustein

aixigo AG - Financial Research and Education
Schloﬂ-Rahe-Straﬂe 15, 52072 Aachen, Germany
Phone +49 (241) 93 67 37 - 40, Fax +49 (241) 93 67 37 - 99
E-Mail T.Haustein@aixigo.de, Web http://www.aixigo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
