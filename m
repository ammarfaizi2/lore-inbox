Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424995AbWLCGSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424995AbWLCGSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 01:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424996AbWLCGSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 01:18:34 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:55492 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S1424995AbWLCGSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 01:18:33 -0500
Message-Id: <200612030618.kB36IMxU003340@ms-smtp-02.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: <akpm@osdl.org>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Sun, 3 Dec 2006 00:18:26 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AccWopbH3gQk/oKlTd2nr0VLkKgi1QAACm3g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reformatted as plain text.

________________________________________
From: Aucoin [mailto:Aucoin@Houston.RR.com] 
Sent: Sunday, December 03, 2006 12:17 AM
To: 'akpm@osdl.org'; 'torvalds@osdl.org'; 'linux-kernel@vger.kernel.org';
'clameter@sgi.com'
Subject: la la la la ... swappiness

I set swappiness to zero and it doesn't do what I want!

I have a system that runs as a Linux based data server 24x7 and occasionally
I need to apply an update or patch. It's a BIIIG patch to the tune of
several hundred megabytes, let's say 600MB for a good round number. The
server software itself runs on very tight memory boundaries, I've
preallocated a large chunk of memory that is shared amongst several
processes as a form of application cache, there is barely 15% spare memory
floating around.

The update is delivered to the server as a tar file. In order to minimize
down time I untar this update and verify the contents landed correctly
before switching over to the updated software.

The problem is when I attempt to untar the payload disk I/O starts caching,
the inactive page count reels wildly out of control, the system starts
swapping, OOM fires and there goes my 4 9's uptime. My system just suffered
a catastrophic failure because I can't control pagecache due to disk I/O.
I need a pagecache throttle, what do you suggest?




