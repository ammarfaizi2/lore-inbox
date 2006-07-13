Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWGMDvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWGMDvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 23:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWGMDvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 23:51:46 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:5318 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S932149AbWGMDvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 23:51:45 -0400
Message-ID: <44B5C353.9060007@namesys.com>
Date: Wed, 12 Jul 2006 20:51:47 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Mahoney <jeffm@suse.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <44B52674.8060802@suse.com> <20060712175542.108e6e37.akpm@osdl.org>
In-Reply-To: <20060712175542.108e6e37.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Wed, 12 Jul 2006 12:42:28 -0400
>Jeff Mahoney <jeffm@suse.com> wrote:
>
>  
>
>> On systems with block devices containing slashes (virtual dasd, cciss,
>> etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
>> it being interpreted as a subdirectory. The generic block device code
>> changes the / to ! for use in the sysfs tree. This patch uses that
>> convention.
>>    
>>
>
>Isn't it a bit dumb of us to be putting slashes in the device names anyway?
> It would be better, if poss, to alter dasd/cciss/etc and stop all these
>s@/@!@everywhere games.
>
>
>  
>
Isn't better to ask why there is a problem with the /'s?  It would be
bad for Linux as a design to prevent passing arbitrary tail ends of
filenames off to arbitrary plugins of some kind.  In general, in
namespace design, you want to allow delegating the job of
resolving/interpreting the tail end of a file that the front end has
identified as something that can interpret it.

Forgive me, I probably understand something wongly about procfs and this
issue....

Hans
