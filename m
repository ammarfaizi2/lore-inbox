Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265818AbRF2Jmc>; Fri, 29 Jun 2001 05:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbRF2JmW>; Fri, 29 Jun 2001 05:42:22 -0400
Received: from idiom.com ([216.240.32.1]:60686 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S265816AbRF2JmM>;
	Fri, 29 Jun 2001 05:42:12 -0400
Message-ID: <3B3C4974.87040108@namesys.com>
Date: Fri, 29 Jun 2001 02:25:08 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Edmund GRIMLEY EVANS <edmundo@rano.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: directory order of files
In-Reply-To: <20010629101818.A13817@rano.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edmund GRIMLEY EVANS wrote:
> 
> With Linux ext2, and some other systems, when you create files in a
> new directory, the file system remembers their order:
> 
> $ mkdir new
> $ cd new
> $ touch one two three four
> $ ls -U
> one  two  three  four
> 
> (1) Is there any standard that says a system should behave this way?
> Is there any software that depends on this behaviour?

Unix filesystem hierarchies are defined to be a partial ordering, not a full ordering.

> 
> (2) Are there Linux file systems that don't work this way? Maybe
> someone with a mounted writable reiserfs could do a quick check.
> 
> Please copy replies to me as I am not subscribed. Thanks.

bash-2.05# mkdir fu
bash-2.05# cd fu
bash-2.05# touch one two three four
bash-2.05# ls -U
one  two  four	three

Hans
