Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVALPXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVALPXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVALPXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:23:09 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:57292 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261220AbVALPUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:20:11 -0500
Message-ID: <41E53F27.9000502@nortelnetworks.com>
Date: Wed, 12 Jan 2005 09:15:51 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: selvakumar nagendran <kernelselva@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Removing a module even if use count is not zero
References: <20050112085345.88349.qmail@web60607.mail.yahoo.com>
In-Reply-To: <20050112085345.88349.qmail@web60607.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selvakumar nagendran wrote:
> hello linux-experts,
>     I inserted my module into the running kernel that
> intercepts read system call. I am using kernel 2.4.28.
> Now, I am unable to remove it since each and every
> time, the module is used by some process. How can I
> remove the module even if the usecount is not zero?
>     Can anyone help me regarding this?

As already said, you need to reboot.

To fix this in the future, export a /proc entry that when written to 
causes your module to properly clean everything up and prevent anyone 
from getting new accesses.  This then allows you to remove the module 
cleanly.  Note that it may not be possible to cleanly deregister, 
depending on what your module is doing.

Chris
