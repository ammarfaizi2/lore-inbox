Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293633AbSCKIWp>; Mon, 11 Mar 2002 03:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293634AbSCKIWf>; Mon, 11 Mar 2002 03:22:35 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:39437 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S293633AbSCKIWd>; Mon, 11 Mar 2002 03:22:33 -0500
Message-ID: <3C8C6947.6050609@namesys.com>
Date: Mon, 11 Mar 2002 11:22:31 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rob Turk <r.turk@chello.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44L.0203101822490.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sun, 10 Mar 2002, Alan Cox wrote:
>
>>>It was fabulous at that time. The first time you create a file, it gets ";1"
>>>appended to it's filename. When you edit it, it gets saved under the same name,
>>>this time appended by ";2". Edit it again... whell, you get the picture.
>>>Cleaning up was as simple as "$ PURGE /KEEP=3" to keep the last three versions.
>>>
>>>For these days with sometimes hundreds of files, it might become confusing when
>>>'ls' shows all versions of all files, but back then it worked well.
>>>
>>Its trickier than that - because all your other semantics have to align,
>>its akin to the undelete problem (in fact its identical). Do you version
>>on a rewrite, on a truncate, only on an O_CREAT ?
>>
>
>That's a nice question.  I would dread the scenario where a
>new version was created for each append ;))
>
>Rik
>
I think that file close is the right place for it.

Again, only for those files/plugins that have VERSION_ON_FILE_CLOSE 
enabled.....

With regard to unlink, I think I don't see the problem.  Unlink makes 
the default version non-existent.

You need a default version, something like filenameA/..default with 
filename A resolving to filenameA/..default.  Listing the default 
version of a directory only lists the current default versions of files.

Hans



