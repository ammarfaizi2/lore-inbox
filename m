Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUK2LPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUK2LPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUK2LMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:12:44 -0500
Received: from viking.sophos.com ([194.203.134.132]:8965 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261656AbUK2LLK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:11:10 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 29/11/2004 11:10:54,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 29/11/2004 11:10:54,
	Serialize complete at 29/11/2004 11:10:54,
	S/MIME Sign failed at 29/11/2004 11:10:54: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 29/11/2004 11:11:02,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 29/11/2004 11:11:02,
	Serialize complete at 29/11/2004 11:11:02,
	S/MIME Sign failed at 29/11/2004 11:11:02: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 29/11/2004 11:11:05,
	Serialize complete at 29/11/2004 11:11:05
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, marcelo.tosatti@cyclades.com
Subject: [BUG ?] smbfs open always succeeds
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF1B8F5314.B5D69DDC-ON80256F5B.003CE2DB-80256F5B.003D6F85@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Mon, 29 Nov 2004 11:11:02 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I posted a possible bug report to the maintainer about 10 days ago but 
with no response, therefore here it goes again. As far a I can tell it is 
common for both 2.4 and 2.6.

Sorry if this is not a bug but some hidden functionality!

--- snippet from the original mail to the maintainer ---

Looking at linux-2.6.9/fs/smbfs/file.c line 365 (end of the smb_file_open 
function). Shouldn't it be "return result;" instead of "return 0;" ?

I've been tracing some strange behaviour and this fixed it for me. But I 
am far away from being an expert. :)


