Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLMIEw>; Wed, 13 Dec 2000 03:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLMIEm>; Wed, 13 Dec 2000 03:04:42 -0500
Received: from Prins.externet.hu ([212.40.96.161]:48148 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129421AbQLMIEc>; Wed, 13 Dec 2000 03:04:32 -0500
Date: Wed, 13 Dec 2000 08:33:47 +0100 (CET)
From: Boszormenyi Zoltan <zboszor@externet.hu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: John Cavan <johncavan@home.com>, " Paul C. Nendick" <pauly@enteract.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.16 SMP: mtrr errors
In-Reply-To: <F7CD5C16569@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.02.10012130829400.19474-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000, Petr Vandrovec wrote:
> That's wrong. They must first register MTRR and then split it to
> 24+8, as they cannot register 24MB range. They can split it
> 16+16, or (16+8)+8, but at cost of 1 (or 2) additional MTRR entries -
> and there is very limited number of possible MTRRs.
> 
> Matroxfb also splits Matrox memory in 24:8, but it registers only one
> region in mtrr. Of course, in X, as mtrr registration is done by map
> videomemory, you must tell this function to not register mtrr...
> 
>                                             Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz

NOW, I am really convinced that we need PAT support on top
of the crappy MTRR driver. :-) I already started working on it...


Regards,
Zoltan Boszormenyi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
