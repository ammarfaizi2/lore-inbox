Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136113AbREDKKP>; Fri, 4 May 2001 06:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136122AbREDKJz>; Fri, 4 May 2001 06:09:55 -0400
Received: from gatekeeper-s.gts.cz ([194.213.203.154]:42489 "HELO
	smtp.idoox.com") by vger.kernel.org with SMTP id <S136113AbREDKJy>;
	Fri, 4 May 2001 06:09:54 -0400
Date: Fri, 4 May 2001 12:09:46 +0200 (CEST)
From: Jacek Kopecky <jacek@idoox.com>
X-X-Sender: <jacek@bimbo.in.idoox.com>
To: <linux-kernel@vger.kernel.org>
Subject: tmpfs doesn't update free memory stats?
Message-ID: <Pine.LNX.4.33.0105041159301.31964-100000@bimbo.in.idoox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello. 8-)
 I'm not in the list, please cc your replies to me.
 After upgrading to 2.4.4 I started using tmpfs for /tmp and I
noticed a strange behavior:

 dd if=/dev/zero of=blah bs=1024 count=102400
	# increased my used swap space by approx. 100MiB (correct)
 rm blah
	# did not decrease it back

 Multiple retries showed what looked like a random behavior of
the used swap stats. Is this a correct behavior? Should the swap
stats be dismissed as 'unreliable'? I expected that when creating
a 100MiB file in memory it should increase the swap (or memory)
usage by cca 100MiB and that removing a file from tmpfs means
freeing the memory.
 Best regards

                            Jacek Kopecky
                               Idoox



