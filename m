Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTDGIEq (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTDGIEq (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:04:46 -0400
Received: from unthought.net ([212.97.129.24]:35500 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id S263319AbTDGIEp (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:04:45 -0400
Date: Mon, 7 Apr 2003 10:16:19 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: andrew <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: Testing with 4000 disks
Message-ID: <20030407081618.GB2473@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Badari Pulavarty <pbadari@us.ibm.com>, andrew <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <200304041024.33418.pbadari@us.ibm.com> <3E8DD614.1060500@us.ibm.com> <200304041355.05296.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304041355.05296.pbadari@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 01:55:05PM -0800, Badari Pulavarty wrote:
> Okay !! I just made all my filesystem except root ext2.
> (I couldn't boot when I configed out ext3 - mounting
> root failed).
> 
> Anyway, problem seem to have gone away..
> Machine is really slow while trying to do IO on
> all 4000 filesystems. It is slowly creating processes.
> System is 100% busy. (so far, it created 461 processes 
> out of 4000). But we are not running out of lowmem and 
> inode caches seems to be reasonable..
> 
> So, it must be some leak in ext3..
> 

Or bad things happening because you have hundreds of processes all
updating the same physical journal...

You mounted rw, and reading a file causes a write due to atime updates.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
