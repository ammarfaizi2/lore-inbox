Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276384AbRJUReU>; Sun, 21 Oct 2001 13:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276397AbRJUReA>; Sun, 21 Oct 2001 13:34:00 -0400
Received: from server.igoweb.org ([207.173.200.73]:31178 "HELO
	server.igoweb.org") by vger.kernel.org with SMTP id <S276384AbRJURdv>;
	Sun, 21 Oct 2001 13:33:51 -0400
Message-ID: <3BD3071F.80805@igoweb.org>
Date: Sun, 21 Oct 2001 10:34:23 -0700
From: "William M. Shubert" <wms@igoweb.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-US, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Help! Unkillable "dd" in kernel 2.4.9
In-Reply-To: <3BD21A41.2080608@igoweb.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, just checked the red hat kernel source, found that my bug has been 
fixed there. Caused by a leak of preallocated raid1 buffer headers. 
Apparently fixed in the Alan Cox kernel series. Dang, wish I'd known 
about this fix before I used the vanilla 2.4.9 raid1 system!

William M. Shubert wrote:

> As the subject says, I am running kernel 2.4.9 (from kernel.org, not 
> the red hat version) and have a "dd" process that stopped halfway 
> through its work and is now unkillable. The "wchan" reports that dd is 
> stuck in "raid1_alloc_r1bh".

...
-- 

Bill Shubert (wms@igoweb.org) <mailto:wms@igoweb.org>
http://www.igoweb.org/~wms/ <http://igoweb.org/%7Ewms/>



