Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130880AbQL0PBp>; Wed, 27 Dec 2000 10:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130897AbQL0PBf>; Wed, 27 Dec 2000 10:01:35 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:8560 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S130880AbQL0PBV>;
	Wed, 27 Dec 2000 10:01:21 -0500
Message-ID: <3A49FC51.F67BABA8@student.ethz.ch>
Date: Wed, 27 Dec 2000 15:27:29 +0100
From: "Giacomo A. Catenazzi" <cate@student.ethz.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@torque.net
Subject: Re: [KBUILD] How do we handle autoconfiguration?
In-Reply-To: <200012262313.eBQNDBi07719@snark.thyrsus.com> <3A49CF1C.19A0FB55@student.ethz.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Dec 2000 14:30:52.0337 (UTC) FILETIME=[9D5EE210:01C07011]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot:

The program is in http://people.debian.org/~cate/autoconfigure/

Notes of implementation:

It is a bash script. I've split in two file:
rules file: contain the pci id, device name, resources names,...
  It is in a simple format, so that it can used in other programs.
  Every resource has also a comment writing where I found it in
  kernel sources.
main file: define how to use the rules file and how to detect 
  special configurations.

The autoconfiguration can be done in an external (target) machine
(it doesn't need nothing of kernel, no lspci, no special programs).

Now autoconfigure is in debug mode:
It write some extra debug information and rewrite twice some config
(one for every time it is detected). It write now only to std output,
to not corrupt actual .config files.


	giacomo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
