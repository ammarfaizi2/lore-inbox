Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289343AbSAJJI4>; Thu, 10 Jan 2002 04:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289349AbSAJJIo>; Thu, 10 Jan 2002 04:08:44 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:56040 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S289343AbSAJJIa>; Thu, 10 Jan 2002 04:08:30 -0500
Date: Thu, 10 Jan 2002 09:08:27 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__ - patch for USB
Message-ID: <20020110090827.A9541@axis.demon.co.uk>
In-Reply-To: <3C3CC04D.2080807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3CC04D.2080807@intel.com>; from vladimir.kondratiev@intel.com on Thu, Jan 10, 2002 at 12:12:29AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 12:12:29AM +0200, Vladimir Kondratiev wrote:
> Since I have started this thread, I feel I have to do something real. 
> Dummy technical work, but someone have to do it, right?
> I patched USB subsystem, it uses __FUNCTION__ in deprecated way no more.

 #ifdef DEBUG
-#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format "\n" , ## arg)
+#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ":%s - " format "\n", __FUNCTION__, ## arg)
 #else

I was going to suggest you use the C99 __func__ rather than
__FUNCTION__ but after a quick test it doesn't seem to be supported by
egcs-2.91.66 so I guess that is out for the time being?  It is
supported by gcc-2.95 though.

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
