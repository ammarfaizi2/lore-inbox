Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315601AbSECIg1>; Fri, 3 May 2002 04:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315603AbSECIg0>; Fri, 3 May 2002 04:36:26 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:54543 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315601AbSECIg0>; Fri, 3 May 2002 04:36:26 -0400
X-mailer: xrn 8.03-beta-26
From: pmenage@ensim.com
Subject: Re: [PATCH] missing checks in exec_permission_light()
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
X-Newsgroups: 
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D27C6C7@nasdaq.ms.ensim.com>
Message-Id: <E173YXz-0004wl-00@pmenage-dt.ensim.com>
Date: Fri, 03 May 2002 01:36:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D27C6C7@nasdaq.ms.ensim.com>,
you write:
>Hi!
>
>> +	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
>> +		return 0;
>
>Is this right? This means that root can do cat /, no? That does not
>seem like expected behaviour.
>									Pavel

exec_permission_lite() is only used for MAY_EXEC checks.

Paul
