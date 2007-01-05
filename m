Return-Path: <linux-kernel-owner+w=401wt.eu-S965105AbXAEAOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbXAEAOo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbXAEAOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:14:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:12640 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965105AbXAEAOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:14:43 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,240,1165219200"; 
   d="scan'208"; a="33069937:sNHT18871416"
Message-ID: <459D9872.8090603@foo-projects.org>
Date: Thu, 04 Jan 2007 16:14:42 -0800
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Akula2 <akula2.shark@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
In-Reply-To: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2007 00:14:42.0851 (UTC) FILETIME=[7F8F5F30:01C7305E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akula2 wrote:
> Hello All,
> 
> I am looking to use multiple kernel trees on the same distro. Example:-
> 
> 2.6.19.1 for - software/tools development
> 2.4.34    for - embedded systems development.
> 
> I do know that 2.6 supports embedded in a big way....but still
> requirement demands to work with such boards as an example:-
> 
> http://www.embeddedarm.com/linux/ARM.htm
> 
> My question is HOW-TO enable a distro with multi kernel trees?
> Presently am using Fedora Core 5/6 for much of the development
> activities (Cell BE SDK related at Labs).
> 
> Any hints/suggestions would be a great leap for me to do this on my own.

this is really no big problem (as in: works OOTB), except that if you want to boot & run 
both kernels on the same (rootfs) installation, you will need to create wrappers around 
modutils and module-init-tools, as well as udev/devfs, or whichever device file system 
you prefer to use for each kernel. There are a few minor other details but none really 
shocking.

We've done this for "our" source distro, and it works just fine.

Cheers,

Auke
