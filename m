Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIQ3w>; Tue, 9 Jan 2001 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIQ3m>; Tue, 9 Jan 2001 11:29:42 -0500
Received: from monza.monza.org ([209.102.105.34]:62221 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129226AbRAIQ30>;
	Tue, 9 Jan 2001 11:29:26 -0500
Date: Tue, 9 Jan 2001 08:27:49 -0800
From: Tim Wright <timw@splhi.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109082749.A2971@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Matti Aarnio <matti.aarnio@zmailer.org>,
	Venkatesh Ramamurthy <Venkateshr@ami.com>,
	'Pavel Machek' <pavel@suse.cz>, adefacc@tin.it,
	linux-kernel@vger.kernel.org
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1> <20010109142156.L25659@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109142156.L25659@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Tue, Jan 09, 2001 at 02:21:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:21:56PM +0200, Matti Aarnio wrote:
[...]
> 
>   For IO on usual systems you have 32 bit address space PCI busmasters,
>   so those can access only the lowest 4GB of address space, and to have
>   a block of data in upper area, it needs to be "bounced", that is, CPU
>   must copy it.  Linux 2.4.0 system doesn't support 64-bit PCI addresses
>   at 32-bit systems (not at 64-bit Alpha either, I recall.)
>   On the other hand, Alpha systems and SPARC systems have IOMMU hardware,
>   and we do support that (to some extent), but 32-bit intel world doesn't
>   have similar things.
> 

Hi Matti,
you are correct in saying that ia32 systems don't have IOMMU hardware, but
it's unfortunate that we don't support 64-bit PCI bus master cards, since
they're inexpensive and fairly common now. For instance, the Qlogic ISP SCSI
cards can do 64-bit addressing, as can many others. Has anybody taken a look
at enabling this ?

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
