Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263006AbREaQMp>; Thu, 31 May 2001 12:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbREaQMZ>; Thu, 31 May 2001 12:12:25 -0400
Received: from comverse-in.com ([38.150.222.2]:29638 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S263006AbREaQMQ>; Thu, 31 May 2001 12:12:16 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F09@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Mark Frazer'" <mark@somanetworks.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Makefile patch for cscope and saner Ctags
Date: Thu, 31 May 2001 12:11:24 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great stuff. May I suggest adding -k to the cscope cmdline:

> +	cscope -b -I include

should become 
  +	cscope -b -k -I include

Also, I think you should separate cscope.files creation into a different
rule,
and make the cscope target depend on it and on the files in it. (Like the
stuff
with .flags)

The new .files should be created  in a different file, and the old file
shouldn't 
be replaced if there's no change.

Lastly, you need to clean up. I think cscope.out should be cleaned up
in the clean target, while the cscope.files should probably should only be
cleaned on rmproper or such.

Vassilii
