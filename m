Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTELXpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbTELXpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:45:43 -0400
Received: from impact.colo.mv.net ([199.125.75.20]:714 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP id S262955AbTELXpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:45:41 -0400
Message-ID: <3EC0351D.2050601@bogonomicon.net>
Date: Mon, 12 May 2003 18:58:21 -0500
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
References: <Pine.LNX.4.44.0305130138350.15817-100000@marcellos.corky.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You want it secure, never write it to disk.  If that is not an option, 
then all that is written to a disk must be encrypted.  Anything less is 
a placebo.  Anyways as Alan mentioned:

 > 4. Even then data erasure is not guaranteed because of the drive logic

 From the write speed differences I've seen on my own system between 
writing zero filled buffers and random data filled buffers it looks like 
a good number of drives do zero filled block write optimizations.  From 
the efective write rates on a couple of my drives it looks like they are 
just marking the blocks as zero in a master table rather than really 
writing zeros out to them.

- Bryan

Yoav Weiss wrote:
> Until linux gets a real encrypted swap (the kind OpenBSD implements), you
> can settle for encrypting your whole swap with one random key that gets
> lost on reboot.  Encrypted loop dev with a key from /dev/random easily
> gives you that.
> 
> Download the latest loop-AES from http://loop-aes.sourceforge.net/ and
> follow the "Encrypting swap on 2.4 kernels" section in README.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


