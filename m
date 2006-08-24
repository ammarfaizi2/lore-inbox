Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWHXHPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWHXHPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWHXHPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:15:40 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:22864 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750730AbWHXHPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:15:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QFIggSv8o8Z9VKYtAtNMfUrghI7kcLOZthqYGod+ehExL/FPDRN8/E0feBXVNSxnFqtIh6WmMtXEnsoJ2rM/YLh3k9uFM0VZndhz96wTW0496/gcVfVKihgvgjve5JdU1azR0Q6En92mWcEU/ZlByUOzVnQ/J2gHcDonN6rSx44=
Message-ID: <4ae3c140608240015v6078fc29r287601aad7a2f1dc@mail.gmail.com>
Date: Thu, 24 Aug 2006 03:15:38 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Why will NFS client spend so much time on file open?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did Apache benchmark and collected the performance results at the
file system call level.
The microbenchmark results were collected when I did "make" on Apache
source code.

The results are very interesting:

		      open	        read		
Total Time (s)  21.599 	         15.948 											Count		   310274 	
 98028 											Time/Call (ms)	69.61 	         162.69

The results show that NFS spent even more time on file open than on
file read. But this result confuses me: what does NFS do to open a
file? As far as I know, it just issues a lookup() RPC to get file
handle, and maybe a getattr() RPC to get file attributes. This should
not take so much time. Can someone explain why this could happen?

Thanks,
-x
