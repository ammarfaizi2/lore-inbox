Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbUDEHHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUDEHHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:07:00 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:54247 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263160AbUDEHG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:06:58 -0400
Date: Mon, 5 Apr 2004 18:05:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Carsten Gaebler <ezinye-zinto@snakefarm.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.25 XFS can't create files
Message-ID: <20040405080536.GB9193@frodo>
References: <406D20FE.8040701@snakefarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406D20FE.8040701@snakefarm.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 10:14:54AM +0200, Carsten Gaebler wrote:
> Hi there,
> 
> I have somewhat of an esoteric problem. I can create an XFS on an 
> external fibre channel RAID attached to an LSI fibre channel card 
> (Fusion MPT driver) but I can't create files or directories on that 
> filesystem (Permission denied). ext2/ext3 work fine on the same 
> partition, so I suspect this is an XFS+MPT issue.

Thats very odd - the SGI CVS 2.4 kernel (that you reported
working) is also at 2.4.25, and there's nothing in the XFS
fixes/updates there that might be the cause of this, AFAICT.
ACLs are not in Marcelo's tree, but that is unlikely to be
the cause here (both cases are well tested).  The only other
thing I can suggest is a liberal sprinkling of printks on
the sys_open path, till you find the spot thats returning
this error..

cheers.

-- 
Nathan
