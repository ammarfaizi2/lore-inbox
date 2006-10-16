Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422904AbWJPAD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422904AbWJPAD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWJPAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:03:27 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:63733 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030300AbWJPAD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:03:26 -0400
Message-ID: <4532CC4C.6030005@comcast.net>
Date: Sun, 15 Oct 2006 20:03:24 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG in 2.6.18.1?
References: <4532BBDF.9010800@lwfinger.net>
In-Reply-To: <4532BBDF.9010800@lwfinger.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Larry Finger wrote:
> Running 2.6.18.1, I got the following warning in my log:
> 
> Oct 15 16:24:38 larrylap kernel: BUG: warning at
> kernel/lockdep.c:565/print_infinite_recursion_bug()
> Oct 15 16:24:38 larrylap kernel:  [<c0103b3f>]
> show_trace_log_lvl+0x1af/0x1d0
> Oct 15 16:24:38 larrylap kernel:  [<c0104f4b>] show_trace+0x1b/0x20
> Oct 15 16:24:38 larrylap kernel:  [<c0104f76>] dump_stack+0x26/0x30
> Oct 15 16:24:38 larrylap kernel:  [<c0131099>]
> print_infinite_recursion_bug+0x49/0x50
> Oct 15 16:24:38 larrylap kernel:  [<c01311d5>]
> find_usage_backwards+0x65/0xd0
> Oct 15 16:24:38 larrylap kernel:  [<c0131210>]
> find_usage_backwards+0xa0/0xd0
> Oct 15 16:24:38 larrylap kernel:  [<c0131210>]
> find_usage_backwards+0xa0/0xd0
> Oct 15 16:24:38 larrylap kernel:  [<c0131210>]
> find_usage_backwards+0xa0/0xd0
> Oct 15 16:24:38 larrylap kernel:  [<c0131210>]
> find_usage_backwards+0xa0/0xd0
> Oct 15 16:24:38 larrylap kernel:  [<c0131210>]
> find_usage_backwards+0xa0/0xd0
> Oct 15 16:24:38 larrylap kernel:  [<c0131210>]
> find_usage_backwards+0xa0/0xd0

....

Hmmm...  21 is infinite?  Interesting.

I find that it would be interesting to me personally if the kernel was
smart enough to spit out something like:

Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_[...]+0xa0/0xd0
  [21 times]

(of course, with find_usage_backwards spelled out)

After all, what if it's practical that a specific recursion would run
3000 times and it gets caught at 5000 times?  ("f**king bad design")

Just a pet peeve of mine though.
- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTLMSgs1xW0HCTEFAQLvmQ/+I0ya8tRmqMjzYlqHSzOT7jBP0ExCrmQo
elC3TYyfyGL6GJwlG9MdB5Fklf4DTB7p1Wn89+tua0VgfVJp7E045qCVeoyA/74u
vAYaw2MHS/d2wacZN9SWXyqDvE6lnTbVnU1dQXoiSXYCu8mNQAgC0H2sW14e4qrL
OJQdNTcJ9tV7gwoIbyuGFEP4iUQvNKBqShhtjBn10bvwuX4g+AKGkkbw0P43B2ss
9q6eoNEdfgNNQ+oCUlUr8UauuAkP633SL7Zym8AQ99KQLztne0PG6MfW5BAa6s+X
86hW8Y/6HEbqFJWMs8O3S2aUSnEqvzV/y5DirbdOynjDFi8OdWjMDr5XG4PFuGqP
OhCenxfW+W7YTflHnqnB7Y0cQDvhFL9JrItaBDgfL/DkqF0ThiXjwbEYiid+wRRh
758AuYqlx6HYaHn2s1qqQSNRSuKSUj9YddvQknQgQtkq68vQsZ1v8qezwpJnmkKt
39jSUGV6s/1NHW3VOVrC/b2VThq7JT1qFG/LNuFpjHRs39gj/MK+vTZScHMJDTJe
0g9urF205RJPd2OgHsjhqRx0r+XaTUJtaJltpjcmC09jROTBYADWhGXP9m6lxaLE
liQ3PiX1kePex0rWtH7dgaJMPJJKvUnLuW0w50TYoFY7R02sYseyWtxKLaU0vmaG
w2P0InYQ00E=
=YhSr
-----END PGP SIGNATURE-----
