Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTDQRNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTDQRNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:13:06 -0400
Received: from matrix01.home.net.pl ([212.85.112.31]:16655 "HELO
	matrix01.home.net.pl") by vger.kernel.org with SMTP id S261805AbTDQRNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:13:05 -0400
Message-ID: <3E9EE351.2000608@post.pl>
Date: Thu, 17 Apr 2003 19:24:33 +0200
From: "Leonard Milcin, Jr" <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Kenny Mann <Kennymann@cdrobot.com>, linux-kernel@vger.kernel.org
Subject: Re: Help with virus/hackers
References: <78939086E7E52D4A9CDBEAB7A609781201F68B@mainsrv.cdrobot.com>
In-Reply-To: <78939086E7E52D4A9CDBEAB7A609781201F68B@mainsrv.cdrobot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Mann wrote:

>Another method, that just popped to mind, is perhaps having
>Some form of a network share somewhere to which only write access
>Is granted. No on could list the files, no one could read the files
>(except for admin of course!). I'm unsure if it's possible to allow
>Only additions to files and no deletions... Just a thought.
>
>Samba Masters> Would this be possible via samba?
>

Yes, it is possible,  at least using ftp. If you create ftp, or ftp-like 
service that
allow only storing data in one particular directory for each user 
account (or server
account if we would like to name it this way) and no listing directory 
or reading
files (just a matter of file/dir permissions) then we got the solution. 
Server must
ensure that no one could read or delete a file.

It is even possible to create service with anonymous login. It should serve
one directory, for writing only (no read or list operations) as in 
previous case.
Users should store files with uniqe names, to prevent write errors when new
file have the same name as previously created.

It meets all your requirements. And it is possible to configure almost 
all common
ftp deamons to do their work this way.

Leonard Milcin, Jr

