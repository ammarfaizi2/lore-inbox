Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271715AbRICOB7>; Mon, 3 Sep 2001 10:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271716AbRICOBt>; Mon, 3 Sep 2001 10:01:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7389 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271715AbRICOBc>;
	Mon, 3 Sep 2001 10:01:32 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 3 Sep 2001 14:01:47 GMT
Message-Id: <200109031401.OAA34246@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: RFC - how to quota special characters in filenames in /proc files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Neil Brown <neilb@cse.unsw.edu.au>

    I am interested in opinions that people might have on how to quote
    special characters in filenames in files in /proc.

    Is there any convention already used in some other part of the
    kernel?

/proc/mounts does what mount does - it uses octal escapes:

# mount /dev/sr0 "/a b" -r -t iso9660
# mount | tail -1
/dev/sr0 on /a b type iso9660 (ro)
# cat /proc/mounts | tail -1
/dev/sr0 /a\040b iso9660 ro 0 0
#

Andries



