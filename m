Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWJDAhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWJDAhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWJDAhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:37:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:7940 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1161022AbWJDAhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:37:01 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,252,1157353200"; 
   d="scan'208"; a="140061607:sNHT3731652393"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
In-Reply-To: <4522FB04.1080001@goop.org>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <4522FB04.1080001@goop.org>
Content-Type: text/plain
Organization: Intel
Date: Tue, 03 Oct 2006 16:47:43 -0700
Message-Id: <1159919263.8035.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 17:06 -0700, Jeremy Fitzhardinge wrote:

> How does the generated code change?  Doesn't evaluating the condition 
> multiple times have the potential to cause problems?
> 

I think if the condition changes between two evaluations, we do have a
problem with my fix.  I don't have a better idea to avoid using a local
variable to store the condition.  I think we should at least reverse the
WARN_ON/WARN_ON_ONCE patch if a better way cannot be found.

Tim
