Return-Path: <linux-kernel-owner+w=401wt.eu-S932666AbXARWxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXARWxc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbXARWxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:53:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58566 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932666AbXARWxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:53:31 -0500
From: Andi Kleen <ak@suse.de>
To: Chip Coldwell <coldwell@redhat.com>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Date: Fri, 19 Jan 2007 09:49:47 +1100
User-Agent: KMail/1.9.1
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <200701180915.32944.ak@suse.de> <Pine.LNX.4.64.0701181655300.13116@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701181655300.13116@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701190949.48404.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2007 08:57, Chip Coldwell wrote:

> But it still might be a reasonable thing to do to test the theory that
> the problem is cache coherency across the graphics aperture, even if
> it isn't a long-term solution for the problem.

I suspect it would disturb timing so badly that it might hide the original
problem. If that is true then adding udelays might hide it too. 

Ok i guess you could test with a UP kernel. There change_page_attr
should be much cheaper because it doesn't need to IPI to other CPUs. Also use 
a .2.6.20-rc* kernel that uses CLFLUSH in there, not WBINVD which is also
very costly.

Anyways I guess we can just wait what the hardware people figure out.

-Andi
