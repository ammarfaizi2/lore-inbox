Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWDVS53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWDVS53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWDVS52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:57:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:54593 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750909AbWDVS52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:57:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=qshx4DMvH1QSRvWk/xep4TB/Kn6mhp9d1i3LujbCHHWB0j+7ycXP2vRYtQhk9iTuvTcxz1SRiR5BJGsoegquo9E9dzoZY7qv02amHvfCJsiqjEzO9D1MS7AyEKU8TcXsfJ4uaz8ccuJ2/r8nYttsW3CqMxFQxuQoJPWPNRZAryQ=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Paul Mackerras'" <paulus@samba.org>,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'James Morris'" <jmorris@namei.org>,
       <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: RE: kfree(NULL)
Date: Sat, 22 Apr 2006 11:57:23 -0700
Message-ID: <001201c6663e$983f7960$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <17481.60890.127240.334557@cargo.ozlabs.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZmMNJWbwa2MjaNR8Gvg99mt7tYAwADWuWw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > There is a judgement to be made at each call site of kfree 
> (and similar functions) about whether the argument is rarely 
> NULL, or could often be NULL.  If the janitors have been 
> making this judgement, I apologise, but I haven't seen them 
> doing that.
> 
> Paul.

Even if the caller passes NULL most of the time, the check should be removed.

It's just crazy talk to say "you should not check NULL before calling kfree, as long as you make sure it's not NULL most of the
time".

Hua

