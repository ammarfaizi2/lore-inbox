Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288726AbSADTdV>; Fri, 4 Jan 2002 14:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSADTdM>; Fri, 4 Jan 2002 14:33:12 -0500
Received: from hera.cwi.nl ([192.16.191.8]:1666 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288726AbSADTdI>;
	Fri, 4 Jan 2002 14:33:08 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jan 2002 19:32:34 GMT
Message-Id: <UTC200201041932.TAA226337.aeb@cwi.nl>
To: Nikita@Namesys.COM, jgarzik@mandrakesoft.com
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
Cc: alessandro.suardi@oracle.com, andries.brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (I suggested having init_special_inode taking a kdev_t argument as its
> third arg, but viro yelled at me :))

Yes. If you think that a kdev_t is a pointer to a struct with
device information, then having a kdev_t there is wrong,
because a special device node can have arbitrary major,minor
not necessarily belonging to any device, so rdev should just
have the numbers.

Andries
