Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWFPX3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWFPX3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWFPX3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:29:51 -0400
Received: from alpha.polcom.net ([83.143.162.52]:42972 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932375AbWFPX3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:29:49 -0400
Date: Sat, 17 Jun 2006 01:29:42 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at, viro@ftp.linux.org.uk
Subject: Re: [RFC][PATCH 00/20] Mount writer count and read-only bind mounts
 (v2)
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0606170125110.14464@alpha.polcom.net>
References: <20060616231213.D4C5D6AF@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Dave Hansen wrote:
> The following series implements read-only bind mounts.  This feature
> allows a read-only view into a read-write filesystem.

Thanks, I like this idea very much. I think I have found at least one good
use for it even before it is merged. :-)

But...

> One note: the previous patches all worked this way:
>
> 	mount --bind -o ro /source /dest
>
> These patches have changed that behavior.  It now requires two steps:
>
> 	mount --bind /source /dest
> 	mount -o remount,ro  /dest

Isn't this some kind of security risk (at least in my planned use)? I mean 
- for a small fraction of second somebody seeing /dest can write 
/source... No?


Thanks,

Grzegorz Kulewski

