Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268292AbUHKXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268292AbUHKXBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268297AbUHKWrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:47:36 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:57725 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S268296AbUHKWo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:44:29 -0400
Message-ID: <411AAF69.9080803@myrealbox.com>
Date: Wed, 11 Aug 2004 16:44:41 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040811
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: neilb@cse.unsw.edu.au
Subject: [2.6.8-rc4] New nfsd-related kernel panic
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch of 09Aug is causing kernel panics:

$bk get -D fs/nfsd/nfsxdr.c
237d236
<       int len;
237a237
 >       unsigned int len;
269d268
<       int len;
269a269
 >       unsigned int len;

I can cause a kernel panic by mounting the remote filesystem
read-only and merely copying a moderately large tarball from it.
(The linux-kernel source tarball, for example.)

The panic occurs every time, after only a second or two at most.
It's so easy to reproduce that I haven't copied down the backtrace,
but I will if no one else can reproduce the problem.

Anyone else seeing this?

