Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRFNTD3>; Thu, 14 Jun 2001 15:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRFNTDT>; Thu, 14 Jun 2001 15:03:19 -0400
Received: from 20dyn128.com21.casema.net ([213.17.90.128]:1540 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S263924AbRFNTDM>;
	Thu, 14 Jun 2001 15:03:12 -0400
Date: Thu, 14 Jun 2001 21:01:38 +0200
From: bert hubert <ahu@ds9a.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kip Macy <kmacy@netapp.com>, ognen@gene.pbi.nrc.ca,
        linux-kernel@vger.kernel.org
Subject: Re: threading question
Message-ID: <20010614210138.A15912@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Kip Macy <kmacy@netapp.com>,
	ognen@gene.pbi.nrc.ca, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com> <E15Abr6-00057R-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Abr6-00057R-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 07:28:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:28:32PM +0100, Alan Cox wrote:

> There are really only two reasons for threaded programming. 
> 
> - Poor programmer skills/language expression of event handling

The converse is that pthreads are:

 - Very easy to use from C at a reasonable runtime overhead

It is very convenient for a userspace coder to be able to just start a
function in a different thread. Now it might be so that a kernel is not
there to provide ease of use for userspace coders but it is a factor.

I see lots of people only using:
	pthread_create()/pthread_join()
	mutex_lock/unlock
	sem_post/sem_wait
	no signals
	
My gut feeling is that you could implement this subset in a way that is both
fast and right - although it would not be 'pthreads compliant'. Can anybody
confirm this feeling?

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
