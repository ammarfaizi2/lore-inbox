Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbRDDMKD>; Wed, 4 Apr 2001 08:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132800AbRDDMJx>; Wed, 4 Apr 2001 08:09:53 -0400
Received: from mail.inup.com ([194.250.46.226]:56330 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S132798AbRDDMJm>;
	Wed, 4 Apr 2001 08:09:42 -0400
Date: Wed, 4 Apr 2001 14:13:49 +0200
From: christophe barbe <christophe.barbe@lineo.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep (D state => load_avrg++)
Message-ID: <20010404141349.A6702@pc8.inup.com>
In-Reply-To: <20010404094708.A4718@pc8.inup.com> <E14klGU-0001kB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <E14klGU-0001kB-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on mer, avr 04, 2001 at 13:15:52 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sleep should certainly be interruptible and I that's what I said to the GFS guy.
But what the reason to increment the load average for each D process ?

Thanks,
Christophe

On mer, 04 avr 2001 13:15:52 Alan Cox wrote:
> > The file locking use real IO and so when you ask for a lock, if the loc=
> > k is already owned, you fall in a D state.
> 
> That seems odd. They should be using interruptible sleeps so you can interrupt
> the task waiting for the lock, surely.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
