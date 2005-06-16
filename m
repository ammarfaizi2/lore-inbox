Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVFPU42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVFPU42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVFPU42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:56:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261811AbVFPU4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:56:22 -0400
Date: Thu, 16 Jun 2005 13:57:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org, Hugh Blemings <hab@au1.ibm.com>
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
Message-Id: <20050616135708.4876c379.akpm@osdl.org>
In-Reply-To: <42B1DBF1.4020904@nortel.com>
References: <42B1DBF1.4020904@nortel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> wrote:
>
> 
> The man page for fsync() suggests that it is necessary to call it on the 
> directory fd.

yup.

> However, in the case of tmpfs, fsync() on the file completes, but on the 
> directory it returns -1 with errno==EINVAL.

bad.

> Is there any particular reason for this?

nope.

>  Would a patch that makes it 
> just return successfully without doing anything be accepted?

yup.
