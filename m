Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273001AbTHKR6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272945AbTHKR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:56:12 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40855 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272943AbTHKRxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:53:13 -0400
Date: Mon, 11 Aug 2003 18:52:38 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove useless assertions from reiserfs
Message-ID: <20030811175237.GA1402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E19mFqr-00068B-00@tetrachloride> <3F37D63A.8010500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37D63A.8010500@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:45:30PM -0400, Jeff Garzik wrote:
 > Why are these useless?

read the code not the diff.

 > >@@ -90,10 +90,6 @@ u32 keyed_hash(const signed char *msg, i
 > > 
 > > 	if (len >= 12)
 > > 	{
 > >-	    	//assert(len < 16);
 > >-		if (len >= 16)
 > >-		    BUG();
 > >-
 > > 		a = (u32)msg[ 0]      |
 > > 		    (u32)msg[ 1] << 8 |
 > > 		    (u32)msg[ 2] << 16|
 > 
 > Seems like a valid check to me...

Above this loop is another loop which we don't exit until len < 16

	Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
