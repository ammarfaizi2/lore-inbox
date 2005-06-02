Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVFBGxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVFBGxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 02:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVFBGxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 02:53:10 -0400
Received: from [213.170.72.194] ([213.170.72.194]:12258 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261587AbVFBGxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 02:53:07 -0400
Message-ID: <429EACC9.30303@yandex.ru>
Date: Thu, 02 Jun 2005 10:52:57 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-kernel@vger.kernel.org
Subject: Re: Writing large files onto sync mounted MMC corrupts the FS
References: <20050601091320.GA1472@angel.research.nokia.com> <20050601131006.GL23621@csclub.uwaterloo.ca>
In-Reply-To: <20050601131006.GL23621@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> In other words: Don't use sync with flash media.  It's a horribly bad
> idea, and if you look into how flash works (at least the cheaper ones)
> you will realize why.  Anything with a limited number of writes allowed
> to each sector should avoid rewriting the same sector again and again,
> and that is what sync does when you use filesystems designed for disks
> rather than flash.  JFFS was designed for flash use and rotates the
> sectors it uses to store filesystem meta data and has spare space in the
> filesystem to do wearleveling at the filesystem level.  vfat and ext2/3
> do not, and it shows.  At least write caching/delayed write back
> elliminates the worst of the rewriting of the meta data sectors.
>
So, we should first ask whether this happens with *new* MMC cards or not.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
