Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRJEUWS>; Fri, 5 Oct 2001 16:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271906AbRJEUWI>; Fri, 5 Oct 2001 16:22:08 -0400
Received: from quechua.inka.de ([212.227.14.2]:10504 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S271987AbRJEUV7>;
	Fri, 5 Oct 2001 16:21:59 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <20011005163807.A13524@gruyere.muc.suse.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15pbUG-0007dI-00@calista.inka.de>
Date: Fri, 05 Oct 2001 22:22:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011005163807.A13524@gruyere.muc.suse.de> you wrote:
>> if (file->mtime != mtime || file->gen_count != gen_count)
>>      file_changed=1;

> And how would you implement "newer than" and "older than" with a generation
> count that doesn't reset in a always fixed time interval (=requiring
> additional timestamps in kernel)?  

newer:

if ((file->mtime < mtime) || ((file->mtime == mtime) && (file->gen_count < gen_count))

The Advantage here is, that even can contain some usefull info like "x
modifications".

Greetings
Bernd
