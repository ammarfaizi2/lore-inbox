Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTIKLHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTIKLHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:07:10 -0400
Received: from [217.129.131.20] ([217.129.131.20]:260 "HELO
	kore.nara.homeip.net") by vger.kernel.org with SMTP id S261218AbTIKLHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:07:05 -0400
From: Ricardo Bugalho <ricardo.b@zmail.pt>
Subject: Re: nasm over gas?
Date: Thu, 11 Sep 2003 12:07:01 +0100
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Message-Id: <pan.2003.09.11.11.06.59.523742@zmail.pt>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309052028.37367.insecure@mail.od.ua> <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com> <200309100034.58742.insecure@mail.od.ua>
To: linux-kernel@vger.kernel.org, insecure@mail.od.ua
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003 00:34:57 +0300, insecure wrote:
 
> That instruction is in main() initialization sequence. I.e. it is
> executed once per program invocation. Summary: we lost 8 bytes for no
> gain. There's not even a speed gain - we lost 8 bytes of _icache_, that
> will bite us somewhere else.

You're quite right, but the I-Cache is a non issue: this code will be
evicted when there is need to put something else. And because its only run
once at the beginning of the program, it won't cause anything important to
be evicted. You can complain about the time it gets to fetch the code from
RAM though.

Quoting another post from you: "I do _not_ advocate using asm anywhere
except speed critical code."
This code is obviously not critical. So, it makes a bad choice for
discussion.

-- 
	Ricardo

