Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUBIIwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUBIIwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:52:38 -0500
Received: from gw-nl4.philips.com ([161.85.127.50]:42169 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP id S264420AbUBIIwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:52:36 -0500
Message-ID: <40274AEF.8040600@basmevissen.nl>
Date: Mon, 09 Feb 2004 09:55:11 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net> <20040129114400.GA27702@thunk.org> <4020BA67.9020604@basmevissen.nl> <20040206191840.GB2459@thunk.org>
In-Reply-To: <20040206191840.GB2459@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

> 
> Was it just the permissions screwy?  Was the contents of these files
> with the "funny" permission sane, or did they contain garbage?  What
> about the modtime of the files?
> 

Only permissions. Something like r-Sr-S--- . File  contents were OK.

> The question is whether the problems you are seeing seem to be caused
> by wholesale corruption of an entire block of the inode table, or is
> some other kind of problem.  For example, if only the permissions are
> getting screwed up, when the rest of the inode data is correct, then
> yes, it would most likely be a filesystem bug.  I haven't noticed any
> such problem myself, but it's possible that something like that might
> be going on.  On the other hand, if it is an entire block in the inode
> table getting corrupted then I'd be less likely to presume it to be a
> filesystem flaw.
> 

It looks like this only appeared once. The FS looks fine now. So I guess 
  I won't be able to reproduce it. Let's just go to 2.6.[23] and see if 
it happens again.

Regards,

Bas.


