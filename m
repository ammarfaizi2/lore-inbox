Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271196AbRHOOEt>; Wed, 15 Aug 2001 10:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271195AbRHOOEj>; Wed, 15 Aug 2001 10:04:39 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:24595 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271192AbRHOOEZ> convert rfc822-to-8bit; Wed, 15 Aug 2001 10:04:25 -0400
X-Apparently-From: <xioborg@yahoo.com>
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: God <atm@sdk.ca>
Subject: Re: [BUG?] :: "Value too large for defined data type"
Date: Wed, 15 Aug 2001 09:04:36 -0500
Message-ID: <b20lntcsat5m102oo7b0n8i6rof9216gab@4ax.com>
In-Reply-To: <Pine.LNX.4.21.0108150418230.8270-100000@scotch.homeip.net>
In-Reply-To: <Pine.LNX.4.21.0108150418230.8270-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a non-LFS system available to me right now, so I haven't
tested this, but  how about truncating the files first...

bash# >box1.071401.dump
bash# >test
bash# rm box1.071401.dump test

Steve Brueggeman



On Wed, 15 Aug 2001 04:22:05 -0400 (EDT), you wrote:

<snip>
>Trying to check where dump should have written the file on box2, I get:
>
># ls -al
>/bin/ls: test: Value too large for defined data type
>total 2097216
>drwxrwxrwx   2 root     root        32768 Aug 14 23:27 ./
>drwxrwxrwx  50 root     root        32768 Aug 14 21:02 ../
>-rwxrwxrwx   1 root     root     2147483647 Aug 14 22:11
>box1.071401.dump*
>#
>
<snipage>
># echo *
>box1.071401.dump test
>#
>
>I tried to remove the file using rm, but I get the same error as ls:
>
># rm test
>rm: cannot remove `test': Value too large for defined data type
># 
>
>
>Any thoughts?  


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

