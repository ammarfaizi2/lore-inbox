Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUIXKOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUIXKOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268663AbUIXKOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:14:07 -0400
Received: from secure.isolservers.com ([66.98.204.49]:44252 "EHLO
	secure.isolservers.com") by vger.kernel.org with ESMTP
	id S268646AbUIXKN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:13:56 -0400
Subject: strange behavior creating and deleting files
From: Mpourtounis Dimitris <db@wless.gr>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096020827.4089.7.camel@WLESS>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 24 Sep 2004 13:13:47 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

there seems to be a strange behaviour in the way my system creates and
deletes files, as long as memory allocation is concerned.

running a simple script that continuously creates and deletes files on
tmpfs filesystem, a got the following results:

files created		free memory on system 
-------------		---------------------
0			48180
+6000			47936
+6000			47372
+6000			47372
+6000			47936
+6000			47936
+6000			47936
+6000			47936		(seems stable)
+9000			46976		(what on earth?)
+30000			45084
+80000			45084		(again stable)
+70000			39156		(not again...:( )

and sometime in the morning 25000 MB free RAM, and my system running too
slow

I am sure these are a lot a files and under normal conditions, there
will never be made and deleted so many.

It is that misbehavior of being stable for a long time and then again
allocating memory that concerns me.

I am running linux 2.4.26 on an x86 platform (gcc 3.2.3 uclib 0.9.20) 

Simple sh file:
i=0
while [ 1 ] do
echo "dont allocate more memory please" > $i
rm $i
let i=$i+1
done

Any clue???


