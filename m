Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVFPOqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVFPOqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 10:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVFPOqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 10:46:18 -0400
Received: from alog0328.analogic.com ([208.224.222.104]:37563 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261554AbVFPOqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 10:46:12 -0400
Date: Thu, 16 Jun 2005 10:44:52 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Lukasz Stelmach <stlman@poczta.fm>, mru@inprovide.com,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
In-Reply-To: <20050616133904.GU23488@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0506161036370.30607@chaos.analogic.com>
References: <f192987705061303383f77c10c@mail.gmail.com> <yw1xslzl8g1q.fsf@ford.inprovide.com>
 <42AFE624.4020403@poczta.fm> <200506150454.11532.pmcfarland@downeast.net>
 <42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com>
 <42B04090.7050703@poczta.fm> <20050615212825.GS23621@csclub.uwaterloo.ca>
 <42B0BAF5.106@poczta.fm> <20050616133904.GU23488@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Lennart Sorensen wrote:

> On Thu, Jun 16, 2005 at 01:34:13AM +0200, Lukasz Stelmach wrote:
>> That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
>> software that need not to be aware of unicodeness of the text it manages
>> to handle it without any hickups *and* to store in the text information
>> about multibyte characters.What characters exactly you do mean? NULL?
>> There is no NULL byte in any UTF-8 string except the one which
>> terminates it.
>
> That is true.  UTF-8 wouldn't cause any more problems than ascii already
> does, such as some filesystems not allowing : and * in filenames among
> other characters.
>
>> Yes, it uses unicode. And dos codepages in short ones. To prove this
>> take a vfat floppy and mount it. touch(1) a file on it that has some
>> non latin1 characters. Unmount the floppy then do dd if=/dev/fd0
>> of=/tmp/floppy bs=1024 count=512. While it's done take some hex
>> editor/viewer and seek the latin1-complaint part of the filename
>> in the floppy file (search for uppercase string). Righ above the short
>> filename you'll find multibyte long one.
>
[SNIPPED...]

>
> Len Sorensen

You know this problem was "solved" over 20 years ago when it was
discovered that file-names could never be long enough. The solution
was a container-file which contained as much stuff as necessary to
identity the contents of the file that it was associated with. Using
this technique, the "real" file didn't need any ASCII identifiers. The
real file didn't show up in some directory program, just the contents
of the container-file. This same technique could be used for any
arbitrary file-identification including characters that haven't been
invented yet.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
