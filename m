Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbUK3P1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUK3P1Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUK3P1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:27:16 -0500
Received: from viking.sophos.com ([194.203.134.132]:12804 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S262117AbUK3PTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:19:25 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 30/11/2004 15:19:10,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 30/11/2004 15:19:10,
	Serialize complete at 30/11/2004 15:19:10,
	S/MIME Sign failed at 30/11/2004 15:19:10: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 30/11/2004 15:19:19,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 30/11/2004 15:19:19,
	Serialize complete at 30/11/2004 15:19:19,
	S/MIME Sign failed at 30/11/2004 15:19:19: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 30/11/2004 15:19:24,
	Serialize complete at 30/11/2004 15:19:24
To: akpm@osdl.org, linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       torvalds@osdl.org
Subject: Re: [BUG ?] smbfs open always succeeds
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF080E710F.7E04A0F5-ON80256F5C.0053BD9B-80256F5C.00542AB4@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Tue, 30 Nov 2004 15:19:19 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I posted a possible bug report to the maintainer about 10 days ago but
>with no response, therefore here it goes again. As far a I can tell it is
>common for both 2.4 and 2.6.
>
>Sorry if this is not a bug but some hidden functionality!
>
>--- snippet from the original mail to the maintainer ---
>
>Looking at linux-2.6.9/fs/smbfs/file.c line 365 (end of the smb_file_open
>function). Shouldn't it be "return result;" instead of "return 0;" ?
>
>I've been tracing some strange behaviour and this fixed it for me. But I
>am far away from being an expert. :)

I investigated a bit and found a nfs_open function at 
linux-2.6.9/fs/nfs/inode.c line 906 which also always returns 0. So is 
this a network filesystem way of handling opens and not a bug after all? I 
am not sure though that both nfs and smbfs operate in the same way and am 
not claiming that.

