Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130254AbRBSNcO>; Mon, 19 Feb 2001 08:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130288AbRBSNcD>; Mon, 19 Feb 2001 08:32:03 -0500
Received: from relay1.pair.com ([209.68.1.20]:10245 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S130254AbRBSNbt>;
	Mon, 19 Feb 2001 08:31:49 -0500
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010219130742.1798.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: ethernet driver probs (tulip, de4x5, 3c509)
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
Organization: rows-n-columns
Date: 20 Feb 2001 00:07:42 +1100
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 3 NICs (2*DEC, 1*3c509) in my gateway (P75, 40M RAM).

tulip.o in 2.4.1 insists on selecting 10baseT, no command
line option can convince it otherwise.  tulip.o in 2.2.16 auto
detected media and worked fine.

de4x5.o in 2.4.1 needs to be told the media, then works fine.
de4x5.o in 2.2.16 auto detected media and worked fine.

3c509.0 in 2.4.1 insists on AUI media when cold-booted (power off,
then on), no command line option can convince it otherwise.  First
cold-booting into kernel 2.2.16 and then warm-booting into 2.4.1
works; it will then use the config stored in EEPROM.  Same if I
cold-boot into DOS, run the 3c509 config utility and then warm-boot
into 2.4.1.  This makes it impossible for the system to reboot with
kernel 2.4.1 after power failure.

That 3 (three!) ethernet drivers which worked flawlessly in 2.2.16
misbehave in 2.4.1 to varying degrees seems to me to indicate that
there might be some underlying problem affecting all those drivers.

Any thoughts or suggestions?

-- 
Manfred

