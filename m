Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWHWWUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWHWWUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWHWWUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:20:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23993 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965242AbWHWWUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:20:01 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060823204109.GI28594@kvack.org>
References: <1156359937.6720.66.camel@localhost.localdomain>
	 <20060823192733.GG28594@kvack.org>
	 <1156365357.6720.87.camel@localhost.localdomain>
	 <20060823204109.GI28594@kvack.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:20:03 -0700
Message-Id: <1156371603.6720.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 16:41 -0400, Benjamin LaHaise wrote:
> On Wed, Aug 23, 2006 at 01:35:56PM -0700, Kylene Jo Hall wrote:
> > Example: The current process is running at the USER level and writing to
> > a USER file in /home/user/.  The process then attempts to read an
> > UNTRUSTED file.  The current process will become UNTRUSTED and the read
> > allowed to proceed but first write access to all USER files is revoked
> > including the ones it has open.
> 
> Don't threads share file tables?  What is preventing malicious code from 
> starting another thread which continues writing to the file that the 
> revoke attempt is made on?

Well if they do share file tables then revoking write access from the
file in the file table will revoke access for all threads.  It looks
like sharing or copying the file table is based on a flag to the clone
call and we are looking into whether you could exploit that situation.

Thanks,
Kylie
> 
> 		-ben

