Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbULHX01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbULHX01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbULHX00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:26:26 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:10254 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261403AbULHXZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:25:57 -0500
Date: Thu, 9 Dec 2004 00:25:39 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Greg KH <greg@kroah.com>
cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 048 release
In-Reply-To: <20041208220500.GA19187@kroah.com>
Message-ID: <Pine.LNX.4.61L.0412082349040.18542@rudy.mif.pg.gda.pl>
References: <20041208185856.GA26734@kroah.com> <20041208192810.GA28374@kroah.com>
 <20041208194618.GA28810@kroah.com> <Pine.LNX.4.61L.0412082238420.18542@rudy.mif.pg.gda.pl>
 <20041208220500.GA19187@kroah.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2099152593-1102548339=:18542"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2099152593-1102548339=:18542
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 8 Dec 2004, Greg KH wrote:

> On Wed, Dec 08, 2004 at 10:56:27PM +0100, Tomasz K?oczko wrote:
>>
>> First: is it any real reason for use by udev private copy libsysfs which
>> is statically linked with udev ?
>
> Yes, the "system" version of libsysfs is not always the same one that
> udev wants.

Sorry but from eons spend some time on prepare correct build enviromet 
isn't task for each project maintainers but for persons who tries buid 
specified project from source tree :-|

Try prepare in corect form only udev .. and nothing more :_)

Me and probaly many othet people aroud the word who tries build variose
tools for variouse distributions hates maintainers who includes in project 
tree souce code another projects. Much more haten is project maitainer who 
don't allow in easy way use system avalaible libraries.
Please don't try be listed on this long hated maintainers list ;>

Argument allways is like yours .. and allways this is source ass pain
for distribution maintainers like:

- patchin from each new version for use system avalaible libraries if
   something will be changed in build automations (for udev from may this
   year it hapens .. seven times),

- what if in libsysfs will be discovered some nasty bug ? Why I must audit
   not only libsysfs but also any other projests where libsysfs source was
   included ? (this not hipotetycal case .. do you remember case with for
   example with security bugs in zlib ?).

If you want more argumets for not link statisally look at Solarias 10 why 
*ALL* binaries are linked with shared version of any library and lern 
more .. this is _specialy_ for tools very close to kernel layer.

[..]
>> I'm using udev with shared libsysfs for a months and all works correcly.
>
> Great.  Notice any code size savings?  Yeah, it's not really all that
> much.  You also need static linking when using klibc to get a very tiny
> udev for your boot initramfs image.

This not for code saving but for use only one copy of library by any tools 
which uses specifieed API/ABI. In case any bug on for example libsysfs
which can be fixed without changing API/API all what must be performed is
replace libsysfs shared library .. nothing more.

[..]
>> It makes harder packaging udev if someone will try generate udev in
>> for example rpm form with debug info in separated udev-debug package.
>
> I'm sure those who package up rpms of udev have dealt with this properly
> somehow.  For the rest of the world, I'd prefer to keep the current way.

Greg meybe you are very good kernel hacker (for me you are :) but seems 
you are not so good as person for maintaining user space tools ;>

IMO ony ~1-2% of *all* project uses direct stripping chained directly 
chained in build automation which is used by default. All from this ~1-2% 
because maintainer isn't skilled in some subjects.
Default behavior ~99-98% projects build automations is pass not stripped
binaries. On most of this projects (all which uses for example automake)
producing stripped binaries cen be enabled by add -s to linking options
(usualy LDFLAGS="-s").

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-2099152593-1102548339=:18542--
