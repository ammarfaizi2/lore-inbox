Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUG1UYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUG1UYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUG1UYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:24:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:37795 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263448AbUG1UYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:24:14 -0400
Subject: Re: Use of __pa() with CONFIG_NONLINEAR
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <49810000.1091045752@flay>
References: <1090965630.15847.575.camel@nighthawk>
	 <20040728181645.GA13758@w-mikek2.beaverton.ibm.com>
	 <35960000.1091044039@flay> <1091045615.2871.364.camel@nighthawk>
	 <49810000.1091045752@flay>
Content-Type: text/plain
Message-Id: <1091046231.2871.379.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 13:23:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 13:15, Martin J. Bligh wrote:
> However ... what happens to functions calling __pa that are called from 
> boot time and run time code?

I've actually only run into one of those so far that I know of, and that
was on ppc64 (i386 had none that I found).  In that one case, I used an
if(unlikely()) to optimize for the run-time one.  There might be more,
but I think they're rare enough to just code it with an if() in each
case.

-- Dave

