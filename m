Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261621AbSIXJbh>; Tue, 24 Sep 2002 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSIXJbh>; Tue, 24 Sep 2002 05:31:37 -0400
Received: from [217.167.51.129] ([217.167.51.129]:41928 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261621AbSIXJbg>;
	Tue, 24 Sep 2002 05:31:36 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "Konstantin Kletschke" <konsti@ludenkalle.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Quick aic7xxx bug hunt...
Date: Mon, 23 Sep 2002 09:44:11 +0200
Message-Id: <20020923074411.31595@192.168.4.1>
In-Reply-To: <3D8FA39B.7020201@pobox.com>
References: <3D8FA39B.7020201@pobox.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jeff Garzik wrote:
>> ahc_reset
>>     aic7770_config -> can sleep
>>     ahc_pci_config -> can sleep
>>     ahc_shutdown -> can't sleep, whoops
>
>
>Though, to answer your question from a previous email, you can call the 
>function in_interrupt() to see if you're in interrupt context.

Well... no, you can't rely on it for knowing if you can sleep or
not. in_interrupt() won't tell you interesting things like you
are holding a spinlock...

Ben.


