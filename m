Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271758AbTHDPbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271808AbTHDPbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:31:46 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:31102
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S271758AbTHDPbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:31:45 -0400
Message-ID: <3F2E7C63.2000203@rogers.com>
Date: Mon, 04 Aug 2003 11:31:47 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org,
       =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>	<yw1xsmohioah.fsf@users.sourceforge.net> <20030804152226.60204b61.skraw@ithnet.com>
In-Reply-To: <20030804152226.60204b61.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Mon, 4 Aug 2003 11:30:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

>
>I guess this is not really an option if talking about hundreds or thousands of
>"links", is it?
>  
>
actually hundreds or thounds still should be ok. See...

>From: Alexander Viro <http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&safe=off&q=author:viro%40math.psu.edu+> (viro@math.psu.edu <mailto:viro%40math.psu.edu>)
>Subject: Re: hundreds of mount --bind mountpoints? 
>
>On Sun, 22 Apr 2001, David L. Parsley wrote:
>> Hi,
>> 
>> I'm still working on a packaging system for diskless (quasi-embedded)
>> devices.  The root filesystem is all tmpfs, and I attach packages inside
>> it.  Since symlinks in a tmpfs filesystem cost 4k each (ouch!), I'm
>> considering using mount --bind for everything.  This appears to use very
>> little memory, but I'm wondering if I'll run into problems when I start
>> having many hundreds of bind mountings.  Any feel for this?
>
>Memory use is sizeof(struct vfsmount) per binding. In principle, you can get
>in trouble when size of /proc/mount will get past 4Kb - you'll get only
>first 4 (actually 3, IIRC) kilobytes, so stuff that relies on the contents
>of said file may get unhappy. It's fixable, though.
>
>  
>
The 4Kb problem has also been solved in 2.6, I just tested having
about 5k mounts and things seemed fine. /proc/mounts reports all
of them.

-Jeff

