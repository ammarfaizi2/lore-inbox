Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbTIWWPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTIWWPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:15:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:20172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262141AbTIWWPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:15:03 -0400
Date: Tue, 23 Sep 2003 15:14:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, David Yu Chen <dychen@stanford.edu>,
       linux-kernel@vger.kernel.org, mc@cs.stanford.edu, vojtech@suse.cz
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923151456.A15254@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030923131350.D20572@osdlab.pdx.osdl.net> <20030923202554.GA5485@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030923202554.GA5485@kroah.com>; from greg@kroah.com on Tue, Sep 23, 2003 at 01:25:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> Don't know, Vojtech said he would fix these up already.  Try asking him
> :)

I checked with Vojtech, he said the patch looked OK.  Can you apply?

thanks,
-chris

===== drivers/usb/class/usb-midi.c 1.22 vs edited =====
--- 1.22/drivers/usb/class/usb-midi.c	Tue Sep  2 11:40:27 2003
+++ edited/drivers/usb/class/usb-midi.c	Tue Sep 23 11:36:03 2003
@@ -1750,7 +1750,7 @@
 	return 0;
 
  error_end:
-	if ( mdevs != NULL && devices > 0 ) {
+	if ( mdevs != NULL ) {
 		for ( i=0 ; i<devices ; i++ ) {
 			if ( mdevs[i] != NULL ) {
 				unregister_sound_midi( mdevs[i]->dev_midi );
