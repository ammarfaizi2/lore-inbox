Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWAHH3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWAHH3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWAHH27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:28:59 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:1002 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030367AbWAHH27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:28:59 -0500
From: Grant Coady <gcoady@gmail.com>
To: Markus Rechberger <mrechberger@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Sun, 08 Jan 2006 18:28:53 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <gre1s1lkr687o2npgom26gqq3etgjdjgpo@4ax.com>
References: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com> <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com>
In-Reply-To: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 07:58:09 +0100, Markus Rechberger <mrechberger@gmail.com> wrote:

>Were there any other processes running during the test?
box runs same config both kernels: the usual light load ~100% idle ;)
>what does "vmstat 1" show up during the test?

grant@deltree:~$ uname -r
2.6.14.6a
grant@deltree:~$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
[...]
 0  0      0  63800  11520  32352    0    0     0     0  110    18  0  0 100  0
 0  0      0  63800  11520  32352    0    0     0     0  106    17  1  0 99  0
 3  0      0  63560  11520  32352    0    0     0     0  346   502 22  9 69  0
 1  0      0  63560  11520  32352    0    0     0     0 1057  1987 59 41  0  0
 1  0      0  63560  11520  32352    0    0     0     0 1062  2011 59 41  0  0
 1  0      0  63560  11520  32352    0    0     0     0 1053  2001 50 50  0  0
 1  0      0  63500  11596  32352    0    0     0   136 1054  1974 61 39  0  0
 1  0      0  63500  11596  32352    0    0     0     0 1040  1978 50 50  0  0
 0  0      0  63620  11596  32352    0    0     0     0  799  1425 45 27 29  0
 0  0      0  63620  11596  32352    0    0     0     0  104    12  0  0 100  0
 0  0      0  63620  11596  32352    0    0     0     0  103    10  0  0 100  0

grant@deltree:~$ uname -r
2.4.32-hf32.1
grant@deltree:~$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
[...]
 0  0      0  83192   6532  21404    0    0     0     0  104    12  0  1 99  0
 0  0      0  83152   6572  21404    0    0     0    80  116    24  0  1 99  0
 1  0      0  82952   6572  21404    0    0     0     0  168   130  6  5 89  0
 2  0      0  82952   6572  21404    0    0     0     0  667  1019 65 35  0  0
 0  0      0  83152   6572  21404    0    0     0     0  297   378 41 10 49  0
 0  0      0  83152   6572  21404    0    0     0     0  104     9  0  1 99  0
 0  0      0  83064   6656  21404    0    0     0   304  169   121  0  1 99  0
 0  0      0  83064   6656  21404    0    0     0     0  137    42  0  2 98  0

-- 
Thanks,
Grant.
http://bugsplatter.mine.nu/
