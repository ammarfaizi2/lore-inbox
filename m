Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSHIMpf>; Fri, 9 Aug 2002 08:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSHIMpf>; Fri, 9 Aug 2002 08:45:35 -0400
Received: from hercules.egenera.com ([208.254.46.135]:17935 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S318326AbSHIMpd>; Fri, 9 Aug 2002 08:45:33 -0400
Date: Fri, 9 Aug 2002 08:49:15 -0400
From: Phil Auld <pauld@egenera.com>
To: linux-kernel@vger.kernel.org
Subject: why is lseek broken (>= 2.4.11) ?
Message-ID: <20020809084915.P3542@vienna.EGENERA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

There was a brief thread a couple of months ago about the change in 
lseek for block devices. The thread is here:

http://marc.theaimsgroup.com/?t=102406030100003&r=1&w=2

The change, which looks to have come in with 2.4.11, returns
EINVAL from an lseek on a block device attempting to set pos past 
the size of the device. 
 
This causes current versions glibc to exhibit non-SUS3 lseek behavior.

Are there plans to revert this? It seems that this is something that 
should be addressed in glibc first and then have the kernel change. 

There is no resolution in the thread above, nor is there any 
justification for the change. It just peters out.

Any thoughts?

Thanks,

Phil


-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
