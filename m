Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbTILP0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTILP0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:26:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12809 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261499AbTILP0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:26:37 -0400
Content-Type: text/plain;
  charset="utf-8"
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Ricardo Bugalho <ricardo.b@zmail.pt>, linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Date: Fri, 12 Sep 2003 18:26:22 +0300
X-Mailer: KMail [version 1.4]
References: <20030904104245.GA1823@leto2.endorphin.org> <200309100034.58742.insecure@mail.od.ua> <pan.2003.09.11.11.06.59.523742@zmail.pt>
In-Reply-To: <pan.2003.09.11.11.06.59.523742@zmail.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200309121826.22936.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 September 2003 14:07, Ricardo Bugalho wrote:
> On Wed, 10 Sep 2003 00:34:57 +0300, insecure wrote:
> > That instruction is in main() initialization sequence. I.e. it is
> > executed once per program invocation. Summary: we lost 8 bytes for no
> > gain. There's not even a speed gain - we lost 8 bytes of _icache_, that
> > will bite us somewhere else.
>
> You're quite right, but the I-Cache is a non issue: this code will be

Please disable icache on your CPU ;)

> evicted when there is need to put something else. And because its only run
> once at the beginning of the program, it won't cause anything important to
> be evicted.

How can you know that it won't evict useful code?

> You can complain about the time it gets to fetch the code from
> RAM though.

Thanks for the tip. I missed that!

> Quoting another post from you: "I do _not_ advocate using asm anywhere
> except speed critical code."
> This code is obviously not critical. So, it makes a bad choice for
> discussion.

It makes perfectly fine point that gcc code is not good.
It just wasted 8 bytes in a rather simple code sequence.
-- 
vda
