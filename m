Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWCWWQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWCWWQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWCWWQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:16:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:14284 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932482AbWCWWQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:16:19 -0500
Subject: Re: [patch 06/13] powerpc: cell interrupt controller updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <abergman@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       hpenner@de.ibm.com, stk@de.ibm.com,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Milton Miller <miltonm@bga.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	 <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 09:15:52 +1100
Message-Id: <1143152153.4257.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 00:00 +0100, Arnd Bergmann wrote:
> plain text document attachment (cell-pic-updates-3.diff)
> The current interrupt controller setup on Cell is done
> in a rather ad-hoc way with device tree properties
> that are not standardized at all.
> 
> In an attempt to do something that follows the OF standard
> (or at least the IBM extensions to it) more closely,
> we have now come up with this patch. It still provides
> a fallback to the old behaviour when we find older firmware,
> that hack can not be removed until the existing customer
> installations have upgraded.

BTW... You still use __ioremap(...,PAGE_NO_CACHE); which I think won't
give you guarded... I wouldn'd do that if I were you... The accessors
should have barriers but still...

Ben.


