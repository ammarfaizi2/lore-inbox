Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTEMWih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTEMWih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:38:37 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:46574 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263455AbTEMWiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:38:20 -0400
Message-ID: <3EC176DA.3060702@googgun.com>
Date: Tue, 13 May 2003 18:51:06 -0400
From: Ahmed Masud <masud@googgun.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yoav Weiss <ml-lkml@unpatched.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
References: <Pine.LNX.4.44.0305131645031.20904-100000@marcellos.corky.net>
In-Reply-To: <Pine.LNX.4.44.0305131645031.20904-100000@marcellos.corky.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoav Weiss wrote:

> Masud wrote:
> 
> 
>>But isn't swap crypting fun ? :-) Running encrypted swap is okay so long
>>as we throw away the key after each session.  This can be easily (famous
>>last words) achieved under crypto kernels. I am not certain if such
>>functionaility is being contemplated for the Linux kernel along with the
>>new cryptoloop stuff, if there isn't i can volunteer to put something
>>like that in - if we are interested. Are we?
> 
> 
> See http://loop-aes.sourceforge.net/
> The README already explains how to use it as encrypted swap.  I've been
> using it for quite a while without problems.
> 
I am familiar with Jari's cryptoloop and related tools and have studied 
and am using them for some applications on a few environments.

> If you feel like volunteering for an encrypted swap, I suggest the model
> used by OpenBSD.  Instead of using an encrypted swap dev with one random
> key, they seem to have a per-process key and encrypt swap areas of the
> process with its key.  When a process dies, its key dies with it, so the
> swap space it used is considered clean without having to wait for an
> override or a reboot.
> 

This definitely sounds very interesting.  I can start looking at this 
problem seriously and see if i can put something together for 2.5.x 
since crypto subsystem routines are largely in place.


> Another fun project is encrypted hibernation (suspend-to-disk).  Once the
> kernel contains a stable hibernation option, I'm certainly going to
> encrypt it.
> 

Yes that too could be a fun thing to do.

Ahmed



