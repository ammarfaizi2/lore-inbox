Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSHUAXt>; Tue, 20 Aug 2002 20:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSHUAXt>; Tue, 20 Aug 2002 20:23:49 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:36341 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317540AbSHUAXs>; Tue, 20 Aug 2002 20:23:48 -0400
Date: Tue, 20 Aug 2002 20:27:54 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, tcw@prismnet.com
Subject: Re: mdelay causes BUG, please use udelay
Message-ID: <20020820202754.S21269@redhat.com>
References: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>; from scott.feldman@intel.com on Tue, Aug 20, 2002 at 05:20:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 05:20:02PM -0700, Feldman, Scott wrote:
> > -    msec_delay(10);
> > +    usec_delay(10000);
> 
> Jeff, 10000 seems on the border of what's OK.  If it's acceptable, then
> let's go for that.  Otherwise, we're going to have to chain several
> mod_timer callbacks together to do a controller reset.

10000 is beyond okay.  You've just lost multiple timer ticks.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
