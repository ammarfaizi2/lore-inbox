Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132802AbRDQSZG>; Tue, 17 Apr 2001 14:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132804AbRDQSY4>; Tue, 17 Apr 2001 14:24:56 -0400
Received: from mean.netppl.fi ([195.242.208.16]:38156 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S132802AbRDQSYq>;
	Tue, 17 Apr 2001 14:24:46 -0400
Date: Tue, 17 Apr 2001 21:24:43 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417212443.A8842@netppl.fi>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> <E14pXxg-0002cI-00@the-village.bc.nu> <20010417181524.E2589096@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010417181524.E2589096@informatics.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 06:15:24PM +0200, Jan Kasprzak wrote:
> 	Some more progress: I now downgraded to proftpd without sendfile().
> The CPU usage is now nearly 100% (with ~170 FTP users; with sendfile()
> it was under 50% with >320 FTP users). But nevertheless, the downloaded
> images now seem to be OK.
> 
> 	Should I try the stock 2.4.3 without zero-copy patches?
It might also be useful to try 2.4.3+zc with the dev->features |=
NETIF_F_SG; in the 3c59x driver taken out (so it won't use zero-copy)

Since it starts from the beginning instead of corrupting random packets I
doubt it's a hardware problem, though.

-- 
Pekka Pietikainen



