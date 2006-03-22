Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWCVTjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWCVTjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWCVTjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:39:39 -0500
Received: from mail.parknet.jp ([210.171.160.80]:54022 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932420AbWCVTji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:39:38 -0500
X-AuthUser: hirofumi@parknet.jp
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain>
	<20060320134533.febb0155.rdunlap@xenotime.net>
	<dvn835$lvo$1@terminus.zytor.com>
	<Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
	<44203B86.5000003@zytor.com>
	<Pine.LNX.4.61.0603211854150.21376@yvahk01. <442050C8.1020200@zytor.com>
	<44205BC5.9040200@cfl.rr.com> <44206E1C.6090808@zytor.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Mar 2006 04:39:30 +0900
In-Reply-To: <44206E1C.6090808@zytor.com> (H. Peter Anvin's message of "Tue, 21 Mar 2006 13:20:28 -0800")
Message-ID: <87y7z2l159.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Phillip Susi wrote:
>> H. Peter Anvin wrote:
>> 
>> kernel32.dll's CreateFile() and other apis normally perform translation 
>> which includes special handling for dos device names including AUX.  You 
>> can bypass this by prefixing the absolute file name with the string 
>> "\\?\" and this will allow you to create a file named AUX.  It also 
>> allows you to reference file names with absolute paths greater than 255 
>> characters.
>
> So, in other words, Windows will let you create these files; it will 
> just make you just through hoops to access them.
>
> Sounds like they should be able to be legitimately created.  If the 
> shortnames are mangled, even DOS or Win9x could access them using the 
> shortname.

Looks like we get a good reason to kill strange reserved names in vfat
(and msdos too?).

Could you/anyone check what shortname is used for "AUX" if it is created
in cmd.exe?

Windows may be storing it as shortname, because it seems to be using
completely separated namespace for devices (I guessed from result of
google).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
