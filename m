Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263689AbTIBIcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTIBIcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:32:14 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:11985 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263689AbTIBIcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:32:10 -0400
From: dan carpenter <error27@email.com>
To: linux-kernel@vger.kernel.org
Subject: file system race condition testing
Date: Tue, 2 Sep 2003 01:33:31 -0700
User-Agent: KMail/1.5.3
Cc: shaggy@austin.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309020133.31923.error27@email.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Racer is a bunch of shell scripts that I wrote to try find race conditions in 
JFS code.  I have expanded them to be a general purpose race condition 
tester.  The scripts also found a couple bugs XFS and Reiserfs in 2.6.0-test1 
but those have been fixed in 2.6.0-test4.  

How it works is that the scripts randomly creates files 0 - 20, renames them, 
deletes them, and links to them etc.  If the filesystem survives for a couple 
hours of beating that's considerred a pass.

The scripts are at:
http://kbugs.org/racer.tar.gz

Just use `./racer.sh` to run the scripts.  Obviously, you won't want to run 
the script on a production system.

When I wrote the scripts I tried to think about all the different types of 
operations that you can do on a file but I probably missed a lot of them.  
Probably someone more familiar with filesystem code could provide useful 
feedback.

thanks,
Dan Carpenter


