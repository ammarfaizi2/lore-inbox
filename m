Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLGTBR>; Thu, 7 Dec 2000 14:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLGTA5>; Thu, 7 Dec 2000 14:00:57 -0500
Received: from Cantor.suse.de ([194.112.123.193]:27655 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129255AbQLGTAr>;
	Thu, 7 Dec 2000 14:00:47 -0500
Date: Thu, 7 Dec 2000 19:29:58 +0100
From: Andi Kleen <ak@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andi Kleen <ak@suse.de>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
Message-ID: <20001207192958.A32075@gruyere.muc.suse.de>
In-Reply-To: <20001207190535.A31574@gruyere.muc.suse.de> <Pine.GSO.3.96.1001207190920.21086K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1001207190920.21086K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Dec 07, 2000 at 07:11:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 07:11:57PM +0100, Maciej W. Rozycki wrote:
> On Thu, 7 Dec 2000, Andi Kleen wrote:
> 
> > How often does the NMI watchdog handler run ? 
> 
>  HZ times per second.

Interesting. One of my ports references for PCs lists

0044    r/w     PIT  counter 3 (PS/2, EISA)
                used as fail-safe timer. generates an NMI on time out.
                for user generated NMI see at 0462.



I don't know if modern PCs still provide this counter, but if yes it could
be used for a slow NMI watchdog that only runs every 30s or so. 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
