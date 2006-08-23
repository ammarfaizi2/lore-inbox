Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWHWUlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWHWUlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbWHWUlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:41:16 -0400
Received: from kanga.kvack.org ([66.96.29.28]:15822 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965181AbWHWUlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:41:15 -0400
Date: Wed, 23 Aug 2006 16:41:09 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060823204109.GI28594@kvack.org>
References: <1156359937.6720.66.camel@localhost.localdomain> <20060823192733.GG28594@kvack.org> <1156365357.6720.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156365357.6720.87.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 01:35:56PM -0700, Kylene Jo Hall wrote:
> Example: The current process is running at the USER level and writing to
> a USER file in /home/user/.  The process then attempts to read an
> UNTRUSTED file.  The current process will become UNTRUSTED and the read
> allowed to proceed but first write access to all USER files is revoked
> including the ones it has open.

Don't threads share file tables?  What is preventing malicious code from 
starting another thread which continues writing to the file that the 
revoke attempt is made on?

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
