Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSLVQFK>; Sun, 22 Dec 2002 11:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSLVQFK>; Sun, 22 Dec 2002 11:05:10 -0500
Received: from sabre.velocet.net ([216.138.209.205]:35089 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S264839AbSLVQFJ>;
	Sun, 22 Dec 2002 11:05:09 -0500
To: Greg Stark <gsstark@MIT.EDU>
Cc: Gregory Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
Subject: More tests [Was: Problem with read blocking for a long time on /dev/scd1]
References: <87adj0b3hj.fsf@stark.dyndns.tv> <87u1h799v5.fsf@stark.dyndns.tv>
In-Reply-To: <87u1h799v5.fsf@stark.dyndns.tv>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 22 Dec 2002 11:13:14 -0500
Message-ID: <87of7euj51.fsf_-_@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've done some more tests:

The problem still occurs with straight ide drivers, no ide-scsi

The problem still occurs with 2.4.20-ac2

I removed extraneous llseek syscalls from libdvdread, it's now reading purely
sequentially and still failing. I doubt an llseek to the current location even
gets through to the driver but I figured I would remove another variable.

Question: Does the readahead parameter in hdparm affect accesses to the raw
/dev/hdd device? Does it affect atapi cdrom access?

-- 
greg

