Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132033AbRCYFqf>; Sun, 25 Mar 2001 00:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132047AbRCYFqY>; Sun, 25 Mar 2001 00:46:24 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:2872 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S132033AbRCYFqM>; Sun, 25 Mar 2001 00:46:12 -0500
Message-Id: <4.3.2.7.2.20010324214339.00b228a0@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 24 Mar 2001 21:45:01 -0800
To: <linux-kernel@vger.kernel.org>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <00d801c0b4bb$e7a04be0$0201a8c0@cybercable.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:41 AM 3/25/01 +0100, you wrote:
>If your box is running for example a mail server, and it appears that
>another process is juste eating the free memory, do you really want to kill
>the mail server, just because it's the main process and consuming more
>memory and CPU than others?
>
>Well, fine, your OS is up, but your application is not here anymore.

If you have a mission-critical application running on your box, add it to 
the inittab file with the RESPAWN attribute.  That way, OOM killer kills 
it, init notices it, and init restarts your server.

By the way, are the people working on the OOM-killer also working to avoid 
killing task 1?

Satch

