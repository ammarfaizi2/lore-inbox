Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVANBhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVANBhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVANBdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:33:23 -0500
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:11246 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261720AbVANBak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:30:40 -0500
Subject: Re: 2.6.10-mm3 scaling problem with inotify
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: John Hawkes <hawkes@tomahawk.engr.sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1105663758.6027.215.camel@localhost>
References: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com>
	 <1105663758.6027.215.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jan 2005 20:31:23 -0500
Message-Id: <1105666283.15782.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2005.1.13.28
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 19:49 -0500, Robert Love wrote:
> On Thu, 2005-01-13 at 15:56 -0800, John Hawkes wrote:
> [snip]
> 
> I am open to other ideas, too, but I don't see any nice shortcuts like
> what we can do in inotify_inode_queue_event().
> 
> (Other) John?  Any ideas?

No, you covered things well. This code was really just a straight copy
of the dnotify code. Rob cleaned it up at some point, giving us what we
have today. The only fix I can think of is the one suggested by Rob --
copying the dnotify code again.

-- 
John McCutchan <ttb@tentacle.dhs.org>
