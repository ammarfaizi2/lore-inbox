Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbTJORUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTJORUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:20:35 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:12530
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S263714AbTJORUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:20:33 -0400
Date: Wed, 15 Oct 2003 19:20:30 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       Daniel Blueman <daniel.blueman@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.4.21] 8139too 'too much work at interrupt'...
Message-ID: <20031015172030.GA20098@wind.cocodriloo.com>
References: <16084.1065694106@www3.gmx.net> <20031009163530.GA7001@wind.cocodriloo.com> <3F8C3A48.5090703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8C3A48.5090703@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 02:02:48PM -0400, Jeff Garzik wrote:
> Antonio Vargas wrote:
> >This happens to me also on 2.4.18 and 2.4.19 (yes, I know they are old).
> >
> >Happens about once every 5 months, with the box running at
> >about 1 month uptime per reboot (home server, there is no UPS)
> 
> 
> It's fairly normal for this event to occur.  It's due to the 8139 
> hardware..  sometimes (perhaps during a DoS or ping flood) you can 
> receive far more tiny packets than the driver wishes to deal with in a 
> single interrupt.
> 
> The real solution is to convert the driver to NAPI...
> 
> 	Jeff

NAPI is the method where you block hardware interrupts and
then handle the data by periodic polling? I wonder how could
I get this error, given that my network is a 10Mbit one ;)

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
