Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWJPTra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWJPTra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWJPTra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:47:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:22827 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161012AbWJPTr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:47:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=GVZdhGeBV4P+ZMIxmT7ctyxKsfy0dfnBdf3pEOgxgoB5IYgIioofO7RUqDDClIrtrxInzu1e/AXHoEnIGz82bFFZ4NzeK9ycIUkntknmV8a9t43zrkSc0LsZwpAeu82Ekm2HlCtJ34ydmElOzpap/DVt3br9LnEGETtOncBQhsE=
Date: Mon, 16 Oct 2006 14:47:13 -0500
To: "Oliver Neukum" <oliver@neukum.org>
Subject: Re: copy_from_user / copy_to_user with no swap space
From: mfbaustx <mfbaustx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
References: <op.thi3x1mvnwjy9v@titan> <200610162128.45229.oliver@neukum.org>
Content-Transfer-Encoding: 7bit
Message-ID: <op.thi48zvznwjy9v@titan>
In-Reply-To: <200610162128.45229.oliver@neukum.org>
User-Agent: Opera Mail/9.01 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> No. Your code may be only partially paged into RAM.
>>> The same can happen for any mmaped data.

That's what I thought I read.  But then my question is:  with on-demand  
paging, is it possible to have two processes partially paged?  Surely, it  
MUST be the case that any processes with overlapping logical address  
spaces must be paged coherently.  So, while on-demand "paging-in" allows  
for partial paging of a process, is it the case that, on a context switch,  
the user-space PTE's are completely erased (so that you get page-faults  
and can then on-demand page them in...)?





