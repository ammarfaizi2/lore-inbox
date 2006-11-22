Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756748AbWKVTwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbWKVTwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756753AbWKVTwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:52:05 -0500
Received: from mail.parknet.jp ([210.171.160.80]:6408 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1756748AbWKVTwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:52:03 -0500
X-AuthUser: hirofumi@parknet.jp
To: The Peach <smartart@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<20061122163001.0d291978@localhost>
	<8764d7v4nh.fsf@duaron.myhome.or.jp>
	<20061122201008.17072c89@localhost>
	<87r6vvs2k4.fsf@duaron.myhome.or.jp>
	<20061122203859.017d5723@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Nov 2006 04:51:56 +0900
In-Reply-To: <20061122203859.017d5723@localhost> (The Peach's message of "Wed\, 22 Nov 2006 20\:38\:59 +0100")
Message-ID: <87zmaj1cpv.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Peach <smartart@tiscali.it> writes:

> On Thu, 23 Nov 2006 04:29:15 +0900
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>> This is different thing. Please try "shortname=winnt" or "shortname=mixed"
>> mount option for shortname (default is shortname=lower).
>
> finally it works (mounted with shortname=winnt).
> Did this patch really solve the issue or was just a "shortname" option problem? I didn't even know that option would made the difference.
> now I just should get rid of verbose output.

The both of patch and option should be needed. Because the following
filename is not shortname, shortname option doesn't affect.

If you test shortname=winnt without patch, it should still show the
problem of following filename, but it should be rare case though.

Can you test it?

> -rwxr-xr-x 1 b users 732903 Oct 27 16:55 dscn5981.jpg.rem.2006-10-27-1543 
> -rwxr-xr-x 1 b users 622595 Oct 27 16:55 dscn5982.jpg.rem.2006-10-27-1543
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
