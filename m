Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbRGPTdk>; Mon, 16 Jul 2001 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267691AbRGPTda>; Mon, 16 Jul 2001 15:33:30 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:55120 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S267687AbRGPTdO>;
	Mon, 16 Jul 2001 15:33:14 -0400
Message-ID: <3B53413A.6060501@valinux.com>
Date: Mon, 16 Jul 2001 13:32:10 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: John Cavan <johnc@damncats.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu> <3B532BB7.1050300@valinux.com> <3B533578.A4B6C25F@damncats.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cavan wrote:

> Jeff Hartmann wrote:
> 
>> Actually I have something like this pretty much working.  Unfortunately
>> I was working on a project full time during the 4.1.0 release.  With the
>> addition of this code, the old modules will coexist with newer modules.
>> Basically the newer modules will have their version numbers appended to
>> their names, this way a user can build all the drm modules, and things
>> will just work.  Hopefully we can get a 4.1.1 release out soon which
>> will do this.  This will make the 4.0 -> 4.1 have to be a compile time
>> decision, but 4.1 -> 4.1.1 and higher will just coexist with each
>> other.  I'm currently working out integrating this into the kernel
>> build, and I should hopefully have a patch for Linus and Alan soon.
> 
> 
> Would it not be a bit more robust to have a wrapper module that pulls in
> the correct one on demand? In other words, for the radeon, you would
> still have the radeon.o module, but it would determine which child
> module to load depending on the version of X that is requesting it. Thus
> XFree86 would not require any changes and the backwards compatibility
> would be maintained invisibly.
> 
> John
> 
No, because the 2D ddx module is the one doing all the versioning.  It 
doesn't tell the kernel its version number etc., but the ddx module gets 
the version from the kernel, and fails if its the wrong one.  If the 
kernel was the one doing the checking, then your suggestiong would be a 
nice way of handling it.

-Jeff

