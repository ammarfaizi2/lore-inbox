Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTETEAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 00:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTETEAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 00:00:22 -0400
Received: from terminus.zytor.com ([63.209.29.3]:45191 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263522AbTETEAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 00:00:18 -0400
Message-ID: <3EC9AB3F.1090802@zytor.com>
Date: Mon, 19 May 2003 21:12:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: David Woodhouse <dwmw2@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>	<babhik$sbd$1@cesium.transmeta.com>	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>	<1053392095.21582.48.camel@imladris.demon.co.uk>	<3EC9803F.6010701@zytor.com> <buoy91275r3.fsf@mcspd15.ucom.lsi.nec.co.jp>
In-Reply-To: <buoy91275r3.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>Types use the __kernel_* namespace *only*; structures use struct __kernel_*.
> 
> 
> What, do you mean _every_ kernel internal type would use such names?
> That's completely horrid...
> 

No, I don't mean that.

The kernel-internal headers would typedef these to different names, e.g.

/* linux/types.h */

#include <linux/abi/types.h>

/* Kernel internal types */
typedef __kernel_dev64_t dev_t;
typedef __kernel_ino_t ino_t;

... etc ...

	-hpa


