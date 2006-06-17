Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWFQAK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWFQAK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWFQAK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:10:28 -0400
Received: from alpha.polcom.net ([83.143.162.52]:989 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751187AbWFQAK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:10:27 -0400
Date: Sat, 17 Jun 2006 02:10:17 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at, viro@ftp.linux.org.uk
Subject: Re: [RFC][PATCH 00/20] Mount writer count and read-only bind	mounts
 (v2)
In-Reply-To: <1150501318.7926.22.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0606170202020.14464@alpha.polcom.net>
References: <20060616231213.D4C5D6AF@localhost.localdomain> 
 <Pine.LNX.4.63.0606170125110.14464@alpha.polcom.net>
 <1150501318.7926.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Dave Hansen wrote:
> On Sat, 2006-06-17 at 01:29 +0200, Grzegorz Kulewski wrote:
>> Isn't this some kind of security risk (at least in my planned use)? I mean
>> - for a small fraction of second somebody seeing /dest can write
>> /source... No?
>
> I assume you're talking about this kind of situation:
>
> mount --bind /local/writable/dir /chroot/untrusted/area/
> mount --o remount,ro /chroot/untrusted/area/

Well, actually about some kind of VPS: openvz or something like that. But 
yes, this is the same kind of scenario.


> This has no r/w window in the chroot area:
>
> mount --bind /local/writable/dir /tmp/area/
> mount --o remount,ro /tmp/area/
> mount --bind /tmp/area/ /chroot/untrusted/area/
> umount /tmp/area/

Well, it looks a little scarry and complicated at first. And probably 
requires you to know that semantic of --bind lets you do the last unmount. 
But if you are saying that this makes kernel smaller, faster and less 
buggy then you are probably very right.


Thank you for your explanation,

Grzegorz Kulewski

