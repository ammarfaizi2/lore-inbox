Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUGJO6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUGJO6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 10:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGJO6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 10:58:24 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:38027 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266275AbUGJO6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 10:58:14 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: James Bottomley <James.Bottomley@SteelEye.com>
To: David Teigland <teigland@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 10 Jul 2004 09:58:02 -0500
Message-Id: <1089471483.1750.31.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    gfs needs to run in the kernel.  dlm should run in the kernel since gfs uses it
    so heavily.  cman is the clustering subsystem on top of which both of those are
    built and on which both depend quite critically.  It simply makes most sense to
    put cman in the kernel for what we're doing with it.  That's not a dogmatic
    position, just a practical one based on our experience.
    
    
This isn't really acceptable.  We've spent a long time throwing things
out of the kernel so you really need a good justification for putting
things in again.  "it makes sense" and "its just practical" aren't
sufficient.

You also face two other additional hurdles:

1) GFS today uses a user space DLM.  What critical problems does this
have that you suddenly need to move it all into the kernel?

2) We have numerous other clustering products for Linux, none of which
(well except the Veritas one) has any requirement at all on having
pieces in the kernel.  If all the others operate in user space, why does
yours need to be in the kernel?

So do you have a justification for requiring these as kernel components?

James



