Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVADVZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVADVZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVADVZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:25:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:52937 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262115AbVADVWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:22:31 -0500
Subject: Re: [PATCH] Don't include linux/a.out.h unnecessarily
From: Nathan Lynch <nathanl@austin.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <17812.1104868283@redhat.com>
References: <17812.1104868283@redhat.com>
Content-Type: text/plain
Message-Id: <1104873757.10162.102.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 Jan 2005 15:22:37 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 13:51, David Howells wrote:
> The attached patch prevents unnecessary inclusion of linux/a.out.h since not
> all archs support AOUT and thus may not have asm/a.out.h.
> 
> There was a patch included for this previously, but it seems to have been
> dropped.

Because it breaks the alpha build.  There's a big #ifdef __alpha__ block
in search_binary_handler() which uses definitions from asm/a.out.h.

Sorry, I should have cc'd you on my original report:
http://article.gmane.org/gmane.linux.kernel/263714


Nathan

