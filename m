Return-Path: <linux-kernel-owner+w=401wt.eu-S1945898AbWLVBXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbWLVBXR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 20:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945899AbWLVBXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 20:23:17 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:44762 "EHLO
	mx4.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945898AbWLVBXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 20:23:17 -0500
X-Greylist: delayed 1541 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 20:23:17 EST
Date: Thu, 21 Dec 2006 16:57:19 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <Pine.LNX.4.61.0612220019260.3720@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64N.0612211654370.20138@attu4.cs.washington.edu>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com>  <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
  <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>  <4589BC6E.7040209@tmr.com>
  <Pine.LNX.4.61.0612212151450.3720@yvahk01.tjqt.qr> <1166741599.27218.7.camel@localhost>
 <Pine.LNX.4.61.0612220019260.3720@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006, Jan Engelhardt wrote:

> >These casts can eliminate "return value unused" warnings.
> 
> But only when functions are tagged __must_check, and sprintf is not. 
> cmpxchg is one where (void) is 'needed', __as I wrote__ in a cxgb3 
> comment.
> 

gcc requires functions to be declared with the attribute 
warn_unused_result if a warning should be emitted in these cases.  So 
casting sprintf or any function without warn_unused_result to (void) is 
only visual noise within the source code.  Thus, the patch is correct.

		David
