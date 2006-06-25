Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWFYJh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWFYJh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWFYJh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:37:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:4007 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932186AbWFYJh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:37:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JsjTJRUSfxN2wfsmst+E1rOujtPWO9wItVsVs3qBM6m1QkkOlDJRxujcreON44Bw5lsh3XvgUtdk5opFtqZxlD8CUpnLOy5Oz5MJlYv16s1DB60+gdz57+G7fZWgjP0LpsuglC0dcWZSonWAJs63l1o/XRtXl0FBN7V9hZMGUV0=
Message-ID: <986ed62e0606250237w1e2f759bgdf255e407e873c4f@mail.gmail.com>
Date: Sun, 25 Jun 2006 02:37:56 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Reuben Farrelly" <reuben-lkml@reub.net>
Subject: Re: 2.6.17-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <449E27F2.100@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060624061914.202fbfb5.akpm@osdl.org> <449E27F2.100@reub.net>
X-Google-Sender-Auth: 18a6688f06cb8817
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/06, Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 2.6.17-mm1 was a no-go for me due to the bustage with ReiserFS and bitmaps, even
> the hotfix didn't seem to fix that...  :-(

Take 2.6.17-mm1, apply the hotfix, then apply this patch from 2.6.17-mm2 also:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/broken-out/reiserfs-reorganize-bitmap-loading-functions-fix2.patch

That should make 2.6.17-mm1's reiserfs work. (This way you can at
least see whether your 2.6.17-mm2 bug happens under -mm1 as well.)
-- 
-Barry K. Nathan <barryn@pobox.com>
