Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319304AbSIFSlE>; Fri, 6 Sep 2002 14:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319320AbSIFSlD>; Fri, 6 Sep 2002 14:41:03 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:14768 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S319304AbSIFSlA>; Fri, 6 Sep 2002 14:41:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: /dev/ entries change owner
Date: Fri, 6 Sep 2002 20:45:37 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209062045.37478.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we (all adminitrators from our group) would like to know, why the owner of 
/dev/ entries are changed in 2.4.x kernels on accessing them.

We DON'T use devfs, so this can't be the reason.

For example if the user joerg (in this case also an admin :) )uses the 
soundcard, he magically owns all dsp-entries, though these were previously 
owned by root:

lrwxrwxrwx    1 root     root            9 Apr 12 18:35 /dev/dsp -> /dev/dsp0
crw-rw-rw-    1 joergb   user      14,   3 Apr 12 18:35 /dev/dsp0
crw-------    1 joergb   user      14,  19 Apr 12 18:35 /dev/dsp1
crw-------    1 joergb   user      14,  35 Apr 12 18:35 /dev/dsp2
crw-------    1 joergb   user      14,  51 Apr 12 18:35 /dev/dsp3

Or if the user sven (no admin, so no root rights so he has no possibility to 
affect this behaviour) uses the floppy drive:
 
brw-------    1 sven     user       2,   0 Sep 24  2001 /dev/fd0

Unfortunality this causes that no other user might use the floppy drive -- a 
desaster in a multi user environment (our group has over 40 members).

This seems to happen to lots of devices (another example are tty's) and it is 
distribution independent (I see it at home (Slackware) and at work (Suse)).


Any suggestions what I could do ???



Thanks in advance for your help,

Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut
Abt. Theoretische Chemie
INF 229, 69120 Heidelberg
Tel.: 06221/54-5210
e-mail: 	bernd (dot) schubert (at) pci (dot) uni-heidelberg (dot) de 
