Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbTF2NiH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTF2NiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 09:38:06 -0400
Received: from post.pl ([212.85.96.51]:59654 "HELO matrix01b.home.net.pl")
	by vger.kernel.org with SMTP id S265672AbTF2NiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 09:38:01 -0400
Message-ID: <3EFEEF8F.7050607@post.pl>
Date: Sun, 29 Jun 2003 15:54:23 +0200
From: "Leonard Milcin Jr." <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: mlmoser@comcast.net, jamie@shareable.org, john@grabjohn.com
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk>
In-Reply-To: <20030629132807.GA25170@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> John Bradford wrote:
> I think
> 
>>the performance of an on-the-fly filesystem conversion utility is
>>going to be so much worse than just creating a new partition and
>>copying the data across,
> 
> 
> which is awfully difficult if you have, say, a 60GB filesystem, a 60GB
> disk, and nothing else.
>

I think that filesystem conversion on-the-fly is useless. Why? If you're
making conversion of filesystem, you have to make good backup of data
from that filesystem. It is likely that when something goes wrong during
conversion (power loss) filesystem will be corrupted, and data will be
lost. If you think the data is not worth to make backup - you don't have
to convert it. Just delete worthless filesystem, and create new one. I
the data is worth making backup, and finally you make it - you don't
need to convert it. You could just delete filesystem, and restore data
from copy. If in turn one think the data is worth to protect it from
loss, but he will not do it... he risks that the data will be lost, and
he should not get access to such things.

I think that copying data to another filesystem, and restoring it to
newly created  is most of the time best and fastest method of converting
filesystems.

Regards,

Leonard Milcin Jr.

-- 
"Unix IS user friendly... It's just selective about who its friends are."
                                                        -- Tollef Fog Heen

