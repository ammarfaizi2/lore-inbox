Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTKFOgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTKFOgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:36:13 -0500
Received: from pop.gmx.de ([213.165.64.20]:53961 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263625AbTKFOgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:36:11 -0500
X-Authenticated: #4512188
Message-ID: <3FAA5CCB.5030902@gmx.de>
Date: Thu, 06 Nov 2003 15:38:03 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de> <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de> <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de> <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de>
In-Reply-To: <20031106135134.GA1194@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I found the bugger: It *IS* the sheduler. I tried elevator=deadline 
and all stuttering went away. Before I was using as. mm1 used default 
sheduler (as I think) and ther eno probs. So the (updated?) as sheduler 
in mm2 has a problem...

Prakash


