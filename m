Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317376AbSFCLe2>; Mon, 3 Jun 2002 07:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317377AbSFCLe1>; Mon, 3 Jun 2002 07:34:27 -0400
Received: from oak.sktc.net ([208.46.69.4]:10511 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S317376AbSFCLe0>;
	Mon, 3 Jun 2002 07:34:26 -0400
Message-ID: <3CFB5442.7020504@sktc.net>
Date: Mon, 03 Jun 2002 06:34:26 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SMB filesystem
In-Reply-To: <3CFB03B3.90353B54@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:

> I've been hoping somebody would take this on.
> Question: how will you carry the SMB token around? 


How about using much the same approach that SSH uses - have a daemon 
that is launched from the user's .profile, that listens on an Unix 
domain socket created in the user's home directory and tracks the login 
tokens?

Additionally, that daemon could allow another user space program to 
listen to a socket, and be notified when a request for a non-existant 
token is made - this way when a user is running a GUI, the GUI could 
have a program that can pop up a prompt for the login, and then pass it 
on to the daemon, and then the daemon can inform the process that made 
the request to try again.

I do agree with some of the other posters, though - it seems to me the 
best approach would be a plug-in for autofs that used SMBFS.

