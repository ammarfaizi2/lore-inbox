Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289514AbSAJQMP>; Thu, 10 Jan 2002 11:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289515AbSAJQMF>; Thu, 10 Jan 2002 11:12:05 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:27154 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289514AbSAJQLz>;
	Thu, 10 Jan 2002 11:11:55 -0500
Date: Thu, 10 Jan 2002 08:09:27 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org, Nick Craig-Wood <ncw@axis.demon.co.uk>
Subject: Re: __FUNCTION__ - patch for USB
Message-ID: <20020110160927.GA26783@kroah.com>
In-Reply-To: <3C3CC04D.2080807@intel.com> <20020109222657.GA23143@kroah.com> <3C3D7289.9000302@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3D7289.9000302@intel.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 13 Dec 2001 14:04:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 12:52:57PM +0200, Vladimir Kondratiev wrote:
> Patch against 2.4.18-pre2 attached. For 2.5 tree - wait a bit, I have to 
> return for a moment to business I get salary for.

You still are changing a few dbg() macros that you don't have to change.

Also, info(), warn() and err() should not have __FUNCTION__ added to
them.  Have you tried running the usb code with this patch?  The USB
group gets enough grief about all of the kernel log messages that we
spit out.  We do not need to see the function name for every message we
write (the user does not need it.)

I think I'll wait for the debug level messages cleanup in the 2.5 USB
code to make this kind of change (as talked about in a previous
message.)

thanks,

greg k-h
