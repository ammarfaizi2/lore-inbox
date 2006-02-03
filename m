Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWBCWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWBCWFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWBCWFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:05:11 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:49048 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750722AbWBCWFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:05:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=tUr4SksFFvk8bJ6yfGg+spA9+J3x2eJRHqFUB/DUQVUBBb/kyJpecVzgi4OxY3ciqkgRNpgq9CWqah0rjo5sxUm+27aoo+Q7i4yDCYsAkZzNqEImIoI9kcRnkir1kJNMO2mSFgwqUGvl5RHn9tY25X94lXPMm7p9n4WkFBbFwQs=
Date: Sat, 4 Feb 2006 01:23:20 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: cp hang while copying from cifs
Message-ID: <20060203222320.GA7797@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was copying figure skating tournament 2006 recordings from Windows (?)
SMB share. After a while cp hanged with

	Segmentation fault

The only thing in logs was

	CIFS VFS: Received no data, expecting 9207
	CIFS VFS: No response to cmd 46 mid 1127
	CIFS VFS: Send error in read = -11

OK, reboot, remount, recopying. Evething went fine except

cp: cannot stat `/home/ad/mnt/utaba/TV/-2006   //': No such file or directory
cp: cannot stat `/home/ad/mnt/utaba/TV/-2006   //2': No such file or directory

And dmesg cluttered with

 CIFS VFS: No response to cmd 46 mid 304
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 9207
 CIFS VFS: No response to cmd 46 mid 310
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 519
 CIFS VFS: No response to cmd 46 mid 317
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 519
 CIFS VFS: No response to cmd 46 mid 323
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 9207
 CIFS VFS: No response to cmd 46 mid 334
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 519
 CIFS VFS: No response to cmd 46 mid 349
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 9207
 CIFS VFS: No response to cmd 46 mid 360
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 9207
 CIFS VFS: No response to cmd 46 mid 366
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 9207
 CIFS VFS: No response to cmd 46 mid 377
 CIFS VFS: Send error in read = -11
 CIFS VFS: Received no data, expecting 9207
 CIFS VFS: No response to cmd 46 mid 383
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 5471
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 5520
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 16887
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 16914
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 16947
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 19578
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 19594
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 20328
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 22941
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 29280
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 29293
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 29301
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 1341
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 1349
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 1356
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 1394
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 7914
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 8554
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 48634
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 54926
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response for cmd 50 mid 54931
 CIFS VFS: Send error in read = -9
 CIFS VFS: No response to cmd 46 mid 55453
 CIFS VFS: Send error in read = -11
 CIFS VFS: No response to cmd 46 mid 58629
 CIFS VFS: Send error in read = -11
 CIFS VFS: Send error in read = -9
 CIFS VFS: No response to cmd 46 mid 62938
 CIFS VFS: Send error in read = -11

