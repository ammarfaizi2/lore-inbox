Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131660AbRC1OGh>; Wed, 28 Mar 2001 09:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131777AbRC1OG1>; Wed, 28 Mar 2001 09:06:27 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:55569 "EHLO anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP id <S131660AbRC1OGI>; Wed, 28 Mar 2001 09:06:08 -0500
Message-ID: <F6Om1QA+9ew6EwTq@sis-domain.demon.co.uk>
Date: Wed, 28 Mar 2001 15:04:46 +0100
To: Walter Hofmann <snwahofm@mi.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
From: Simon Williams <announce@sis-domain.demon.co.uk>
Subject: Re: Disturbing news..
References: <01032806093901.11349@tabby> <Pine.GSO.3.96.1010328144551.7198A-100000@laertes>
In-Reply-To: <Pine.GSO.3.96.1010328144551.7198A-100000@laertes>
MIME-Version: 1.0
X-Mailer: Turnpike Integrated Version 5.01 S <Qn604$JeDmmUs1jEKXSOEfAuuD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.3.96.1010328144551.7198A-100000@laertes>, Walter
Hofmann <snwahofm@mi.uni-erlangen.de> writes
>
>
>On Wed, 28 Mar 2001, Jesse Pollard wrote:
>
>> >Any idea?
>> 
>> Sure - very simple. If the execute bit is set on a file, don't allow
>> ANY write to the file. This does modify the permission bits slightly
>> but I don't think it is an unreasonable thing to have.
>
>And how exactly does this help?
>
>fchmod (fd, 0666);
>fwrite (fd, ...);
>fchmod (fd, 0777);
>

I think their point was that a program could only change permissions
of a file that was owned by the same owner.  If a file is owned by a
different user & has no write permissions for any user, the program
can't modify the file or it's permissions.

Sounds like a good plan to me.


-- 
Simon Williams
