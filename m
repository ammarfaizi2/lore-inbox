Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275876AbSIUDxJ>; Fri, 20 Sep 2002 23:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275875AbSIUDxJ>; Fri, 20 Sep 2002 23:53:09 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:5543 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S275876AbSIUDxG>; Fri, 20 Sep 2002 23:53:06 -0400
Date: Fri, 20 Sep 2002 20:58:09 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
To: Greg KH <greg@kroah.com>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <3D8BEE51.1020304@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200207180950.42312.duncan.sands@wanadoo.fr>
 <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com>
 <200209200656.23956.bhards@bigpond.net.au> <20020919230643.GD18000@kroah.com>
 <3D8B884A.7030205@pacbell.net> <20020920231112.GC24813@kroah.com>
 <3D8BDF9A.305@pacbell.net> <20020921033137.GA26017@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Sep 20, 2002 at 07:55:22PM -0700, David Brownell wrote:
> 
>>How about a facility to create the character (or block?) special file
>>node right there in the driverfs directory?  Optional of course.
> 
> 
> No, Linus has stated that this is not ok to do.  See the lkml archives
> for the whole discussion about this.

I suspected that'd be the case.  Some pointer into the archives
would be good, though I'd suspect the basic summary is that it'd
be too much like devfs that way.  Did the same statement apply to
adding some file that wasn't a device special file?  That kind
of solution moves in the "no majors/minors" direction, which I
thought was the general goal.  Leaves a naming policy debate,
but one that ought to be more managable (say, with devlabel).

Though I guess my original reaction still stands then:  I don't
much want to care about major/minor numbers, so why not just leave
them out in favor of whatever better solution is the goal?  Save
everyone the intermediate steps!

- Dave




