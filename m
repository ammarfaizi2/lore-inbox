Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261479AbSIWXXs>; Mon, 23 Sep 2002 19:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSIWXXs>; Mon, 23 Sep 2002 19:23:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261479AbSIWXXr>;
	Mon, 23 Sep 2002 19:23:47 -0400
Message-ID: <3D8FA39B.7020201@pobox.com>
Date: Mon, 23 Sep 2002 19:28:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Quick aic7xxx bug hunt...
References: <20020923180017.GA16270@sexmachine.doom> <2539730816.1032808544@aslan.btc.adaptec.com> <3D8F874B.3070301@mandrakesoft.com> <2640410816.1032818062@aslan.btc.adaptec.com> <3D8F934F.7000606@mandrakesoft.com> <2678680816.1032821098@aslan.btc.adaptec.com> <3D8F9AB9.1040505@mandrakesoft.com> <2687750816.1032821710@aslan.btc.adaptec.com> <3D8FA22A.6050104@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> ahc_reset
>     aic7770_config -> can sleep
>     ahc_pci_config -> can sleep
>     ahc_shutdown -> can't sleep, whoops


Though, to answer your question from a previous email, you can call the 
function in_interrupt() to see if you're in interrupt context.

	Jeff



