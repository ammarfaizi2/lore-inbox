Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132263AbRCVXjj>; Thu, 22 Mar 2001 18:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbRCVXjb>; Thu, 22 Mar 2001 18:39:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42762 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132265AbRCVXjB>; Thu, 22 Mar 2001 18:39:01 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: dwguest@win.tue.nl (Guest section DW)
Date: Thu, 22 Mar 2001 23:40:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stephenc@theiqgroup.com (Stephen Clouse),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010323002752.A5650@win.tue.nl> from "Guest section DW" at Mar 23, 2001 12:27:52 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gEgX-0003Zr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Even if malloc fails the situation is no different.
> Why do you say so?

Because you will fail on other things - stack overflow, signal delivery,
eventually it will get you. You just cut the odds down. 

> > You can do overcommit avoidance in Linux if you are bored enough to try it.
> 
> Would you accept it as the default? Would Linus?

I'd like to have it there as an option. As to the default - You would have to
see how much applications assume they can overcommit and rely on it. You might
find you need a few Gbytes of swap just to boot

