Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTDMXEG (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDMXEG (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:04:06 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41143
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262657AbTDMXEF (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 19:04:05 -0400
Subject: Re: Benefits from computing physical IDE disk geometry?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030413182405.GG676@gallifrey>
References: <200304131407_MC3-1-3441-57C7@compuserve.com>
	 <20030413182405.GG676@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050272088.24564.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Apr 2003 23:14:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-13 at 19:24, Dr. David Alan Gilbert wrote:
> Now given these discs have processors on board isn't it about time
> someone improved the disc interface standards to push some of the
> intelligence drivewards?  I guess with enough intelligence the drive
> could do free block allocation and could do things like copying blocks
> around for you.

I wish it would. Most of the research and stuff so far has either put
the file system into the disk firmware (upgrade hell). Having a disk
which talked entirely about

	read(handle,offset, length)
	write(handle, offset, length)
	alloc(handle, near_handle, length, otherhints...)

might well work out rather better. It also allows the disk to do fairly
major relayout of data as it learns usage.

