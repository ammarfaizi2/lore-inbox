Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129508AbRBMAXh>; Mon, 12 Feb 2001 19:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRBMAX1>; Mon, 12 Feb 2001 19:23:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23820 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129508AbRBMAXQ>; Mon, 12 Feb 2001 19:23:16 -0500
Message-ID: <3A887E68.CFBF6FC5@transmeta.com>
Date: Mon, 12 Feb 2001 16:23:04 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: timw@splhi.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <3A887777.3895D3F8@transmeta.com> <E14ST3g-000094-00@the-village.bc.nu> <20010212161753.B4280@kochanski.internal.splhi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright wrote:
> 
> Yup,
> those who fail to learn from TCP are doomed to re-invent it, badly, at the
> wrong level <GRIN>.
> Seriously, the console subsystem on the Sequent (now IBM) NUMA-Q systems
> originally used UDP. It wound up as a serious mess. We changed to TCP.
> I'll admit that the NUMA-Q console subsystem does more than what is being
> proposed here currently, but it's likely to grow.
> In general UDP is only appropriate if you *can* afford to drop data.
> Did RDP ever get anywhere ?
> 

That's the whole crux of the matter.  For something like this, you *will*
drop data under certain circumstances.  I suspect it's better to have
this done in a controlled manner, rather than stop completely, which is
what TCP would do.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
