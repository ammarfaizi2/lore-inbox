Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270607AbRHIWwF>; Thu, 9 Aug 2001 18:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270606AbRHIWvx>; Thu, 9 Aug 2001 18:51:53 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:6916 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S270605AbRHIWvh>; Thu, 9 Aug 2001 18:51:37 -0400
Date: Thu, 9 Aug 2001 18:50:27 -0400
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Dattatray Kulkarni <dattatray_kulkarni@infy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: procfs doubts
Message-ID: <20010809185027.C7725@arthur.ubicom.tudelft.nl>
In-Reply-To: <B10DD1F99B22C844BC146F2C66BF17F813AD8C@punmsg01.ad.infosys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B10DD1F99B22C844BC146F2C66BF17F813AD8C@punmsg01.ad.infosys.com>; from dattatray_kulkarni@infy.com on Thu, Aug 09, 2001 at 02:53:04PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 02:53:04PM +0530, Dattatray Kulkarni wrote:
> I have some doubts regarding proc file system in linux.
> 1. read_proc & get_info have similar functionality. when i do cat
> /proc/net/some_procfile, read_info function is called. then how & when
> get_info function is called?

AFAIK get_info() is deprecated, you have to use read_proc().

> 2. What is the exact difference between proc_create_entry &
> proc_register?  Is it necessary to write both of these functions?

proc_register() is no longer an exported function, you have to use
proc_create_entry() and friends.

> 3 . How the function write_proc works? and when that function is called
> by the kernel?

It's all explained in the procfs guide in Documentation/DocBook/. Just
run "make psdocs" in your kernel tree and you'll get it nicely
formatted.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
