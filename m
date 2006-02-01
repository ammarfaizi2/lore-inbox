Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422882AbWBATQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWBATQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422884AbWBATQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:16:59 -0500
Received: from fmr23.intel.com ([143.183.121.15]:3781 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422882AbWBATQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:16:58 -0500
Date: Wed, 1 Feb 2006 11:15:54 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch -mm4] i386: __init should be __cpuinit
Message-ID: <20060201111554.A21287@unix-os.sc.intel.com>
References: <200601312352_MC3-1-B748-FCE9@compuserve.com> <200601312352_MC3-1-B748-FCE9@compuserve.com> <20060201053357.GA5335@redhat.com> <E1F4Czv-00018m-00@chiark.greenend.org.uk> <20060201160324.GA5875@redhat.com> <1138820183.3943.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1138820183.3943.11.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 01, 2006 at 06:56:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 06:56:22PM +0000, Alan Cox wrote:
> On Mer, 2006-02-01 at 11:03 -0500, Dave Jones wrote:
> >  > For SMP systems, suspend/resume "unplugs" all non-boot CPUs before
> >  > executing the suspend code. I don't recall any SMP cyrix systems, but
> >  > it's potentially something to consider.
> > 
> > There weren't any.  Until AMD's Athlon MPs, Intel had the only
> > SMP x86 afair.
> 
> Several vendors demonstrated OpenMP designs including Cyrix. Nothing
> production and nothing we support.

In order to support logical cpu hotplug, you dont need any special hw, as long
as you has some SMP box. Sometimes its just a little bit more than 
moving __init to __cpuinit. A lot of these references were not changed
just speculatively to ensure when the need is there, someone will change and
test those as well.

Chuck, would it be possible for you also test cpu hotplug for the ones you 
are interested in and accompany the related changes if there are more
as separate patches? (Documentation now has a howto on cpu hotplug)

That would make it more useful for this exersise.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
