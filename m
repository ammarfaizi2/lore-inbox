Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130014AbRBMASh>; Mon, 12 Feb 2001 19:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbRBMASR>; Mon, 12 Feb 2001 19:18:17 -0500
Received: from monza.monza.org ([209.102.105.34]:21263 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129508AbRBMASI>;
	Mon, 12 Feb 2001 19:18:08 -0500
Date: Mon, 12 Feb 2001 16:17:53 -0800
From: Tim Wright <timw@splhi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
Message-ID: <20010212161753.B4280@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"H. Peter Anvin" <hpa@transmeta.com>,
	Werner Almesberger <Werner.Almesberger@epfl.ch>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A887777.3895D3F8@transmeta.com> <E14ST3g-000094-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14ST3g-000094-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 13, 2001 at 12:11:01AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup,
those who fail to learn from TCP are doomed to re-invent it, badly, at the
wrong level <GRIN>.
Seriously, the console subsystem on the Sequent (now IBM) NUMA-Q systems
originally used UDP. It wound up as a serious mess. We changed to TCP.
I'll admit that the NUMA-Q console subsystem does more than what is being
proposed here currently, but it's likely to grow.
In general UDP is only appropriate if you *can* afford to drop data.
Did RDP ever get anywhere ?

Regards,

Tim

On Tue, Feb 13, 2001 at 12:11:01AM +0000, Alan Cox wrote:
> > I'm sure you can.  That doesn't mean it's the right solution.
> 
> And the UDP proposal will be at least as big if it does retransmits, and if
> it doesnt , its junk. It will also need as much buffering, if not the same
> packing trick
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://vger.kernel.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
