Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbREOVh2>; Tue, 15 May 2001 17:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbREOVhS>; Tue, 15 May 2001 17:37:18 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:34564 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S261577AbREOVhI>;
	Tue, 15 May 2001 17:37:08 -0400
Date: Tue, 15 May 2001 14:37:07 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Bad udelay usage in drivers/net/aironet4500_card.c
Message-ID: <20010515143707.A18074@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.4, drivers/net/aironet4500_card.c has

# grep udelay linux/drivers/net/aironet4500_card.c
                udelay(1000);
        udelay(100);
                udelay(10);
        udelay(100000);
        udelay(200000);
        udelay(250000);
        udelay(10000);
        udelay(10000);
        udelay(1000);
        udelay(1000);
        udelay(10000);

But on ia32, you cannot use more than 20000 for udelay (). You will get
undefined symbol, __bad_udelay.


H.J.
