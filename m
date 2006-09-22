Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWIVSTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWIVSTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWIVSTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:19:31 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:42320 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964855AbWIVSTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:19:31 -0400
Message-ID: <4514292C.5000309@tls.msk.ru>
Date: Fri, 22 Sep 2006 22:19:24 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Johannes Stezenbach <js@linuxtv.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dax Kelson <dax@gurulabs.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com> <20060922140007.GK13639@csclub.uwaterloo.ca> <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr> <4514103D.8010303@zytor.com> <20060922174137.GA29929@linuxtv.org> <451426C9.9040002@zytor.com>
In-Reply-To: <451426C9.9040002@zytor.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Johannes Stezenbach wrote:
>>
>> It seems the "lzma" program from LZMA Utils can:
>>
>> http://tukaani.org/lzma/
>>   "Very similar command line interface than what gzip and bzip2 have."
>>
>> (Debian sid has this in the "lzma" package.)
>>
> 
> Yes, it can.  If that's the way things go then I don't mind it, however,
> my biggest problem with lzma utils is that the command line parsing is
> done in a shell script wrapper.

Well, I don't see any shell code here, in /usr/bin/lzma as in istalled from
debian version 4.43-2.

But note that this lzma utility does not have any 'magic number' and does
no crc checks.  On the site it's said lzma(sdk) is under rewrite to support
new format with magic number and crc checks...

After reading this thread I wanted to teach GNU tar to automatically recognize
..tar.lzma archives - and failed, eactly because of the lack of magic number
at the start of a file...

/mjt
