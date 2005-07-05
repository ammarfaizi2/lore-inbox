Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVGETZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVGETZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVGETZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:25:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26070 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261668AbVGETYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:24:24 -0400
Date: Tue, 5 Jul 2005 21:25:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Message-ID: <20050705192550.GF30235@suse.de>
References: <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <42CAA075.4040406@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CAA075.4040406@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05 2005, Ondrej Zary wrote:
> oread is faster than dd, but still not as fast as 2.4. In 2.6.12, HDD 
> led is blinking, in 2.4 it's solid on during the read.

Oh, and please do test 2.6 by first setting the deadline scheduler for
hda. I can see you are using the 'as' scheduler right now.

# echo deadline > /sys/block/hda/queue/scheduler

Thanks!

-- 
Jens Axboe

