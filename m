Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbREHOGM>; Tue, 8 May 2001 10:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbREHOGC>; Tue, 8 May 2001 10:06:02 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:5117 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S132557AbREHOFx>; Tue, 8 May 2001 10:05:53 -0400
Message-ID: <3AF7FDE8.9C124AA9@kegel.com>
Date: Tue, 08 May 2001 07:08:40 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: fedelman@elsitio.com.ar,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs.file-max
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Edelman Anaya (fedelman@elsitio.com.ar) wrote:

> What can I do to test the FD limit? ... Because, the FD limit is set in 
> /proc/sys/fs/file-max, sample: 
> 
> echo "2048" > /proc/sys/fs/file-max 

That sets the systemwide limit to 2048.  

> ulimit -n 8192 

That sets the per-process limit (for this process
and its children) to 2048.  
 
> In this case ... the FD limit = 8192 :( ... when the limit should be 
> 2048? 

No, the two limits are independant (except, obviously, that
that process will reach the systemwide fd limit before it
exhausts its per-process fd limit).
 
> I wrote a perl script for the test ... anybody known a "C" program for 
> test the FD limit? 

http://www.kegel.com/dkftpbench/#tuning

- Dan
