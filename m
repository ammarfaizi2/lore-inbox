Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUGJFHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUGJFHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 01:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUGJFHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 01:07:13 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48547 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266129AbUGJFHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 01:07:11 -0400
Message-ID: <40EF797E.6060601@namesys.com>
Date: Fri, 09 Jul 2004 22:07:10 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey@comcast.net
CC: Pete Harlan <harlan@artselect.com>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net>
In-Reply-To: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@comcast.net wrote:

>>Reiser3 lets a directory have more than 32000 subdirectories already.
>>I ran into this problem two weeks ago on an ext3 filesystem and found
>>Reiser didn't have the problem.  My reiser3 directory had 1million+
>>subdirs before I killed my test program.
>>
>>I believe it still has a similar limit on the number of hard links,
>>but it doesn't implement ".." as a hard link.
>>
>>--Pete
>>
>>
>>    
>>
>
>NetWare has always supported more than this, so this whole idea of fixed inode tables 
>is somewhat strange to me to start with.  I am still looking through Hans code, but if 
>this is accurate I'll just take a system out Monday and see if it works.  My only concern 
>with Reiser has to do with the bug reports I've seen on it over the years, but Suse is 
>shipping it as default, and we have been running it here for about a year on a production 
>server.  I'll post if it crashes, corrupts data, or has problems.  
>
>Jeff
>
>
>
>
>
>  
>
Don't use it on redhat systems, those bug reports tend to be for redhat 
kernels, redhat refuses to apply our bugfixes that we send in to the 
official kernel because they want us to look bad.  I sound so paranoid 
when I say that, but they really do refuse to apply our bugfixes.

ReiserFS V3 has been very stable for quite some time in 2.4.x.  There 
were some instabilities recently in some versions of 2.6.x due to code 
changes not by our team. sigh....

We at Namesys are much more conservative in code changes for V3 than 
ext*.  I can't control some of the changes by SuSE though that have 
added some bugs that could have been caught by more serious QA.  (SuSE 
adheres to the usual linux lack of QA approach, it is not that they are 
bad, but that they conform to the social norm for linux.)  Hopefully I 
will have more control over that in V4.

Hans
