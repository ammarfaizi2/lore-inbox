Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWH3Rvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWH3Rvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWH3Rvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:51:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38829 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751250AbWH3Rvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:51:41 -0400
Subject: Re: [PATCH] SELinux: work around filesystems which call
	d_instantiate before setting inode mode
From: Eric Paris <eparis@parisplace.org>
To: Steve French <smfrench@austin.rr.com>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, shaggy@austin.ibm.com,
       shirishp@us.ibm.com, akpm@osdl.org
In-Reply-To: <44F50D86.8050706@austin.rr.com>
References: <OF333D0451.97EE96CD-ON872571DA.001579E9-862571DA.001591D1@us.ibm.com>
	 <44F50D86.8050706@austin.rr.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 13:52:32 -0400
Message-Id: <1156960352.3195.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 23:01 -0500, Steve French wrote:
> Eric,
> Does this patch do what you need?
> 
> It rearranges the cifs call to d_instantiate until after the inode is 
> filled in in fs/cifs/readdir.c
> which IIRC was the only place which did the reverse order from what you 
> expected (at
> least the only place in cifs).   I will try it tomorrow but I don't know 
> SE Linux
> scenarios to try that would prove whether it works.

This patch does seem to solve the issue with CIFS that we were
experiencing and I would love to see it submitted.

I would also like to have my original patch included as it will help to
flush out any other cases of this ordering in the future.

-Eric

