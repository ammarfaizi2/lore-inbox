Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbRFKOzQ>; Mon, 11 Jun 2001 10:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbRFKOzG>; Mon, 11 Jun 2001 10:55:06 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46310 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261454AbRFKOzA>;
	Mon, 11 Jun 2001 10:55:00 -0400
Message-ID: <3B24DBAF.390F3BD8@mandrakesoft.com>
Date: Mon, 11 Jun 2001 10:54:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sebastien person <sebastien.person@sycomore.fr>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: netif_start_queue
In-Reply-To: <20010611160330.42083f1e.sebastien.person@sycomore.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sebastien person wrote:
> 
> hi,
> 
> I'm trying to port a ethernet device from 2.2 to 2.4. whith the new way of
> dealing with dev->tbusy and dev->start (e.g. by using netif_startqueue for
> example) I've understand that the netif_start_queue call put a flag that
> telling
> the device isn't busy but I can't found when does the start flag is set .
> 
> I've read somewhere that it is set when the open function return, but I
> haven't
> found where is the matching code.
> 
> In 2.4, must we always check if the device is busy or started, or it is
> upper
> layer work ?

As you appear to be guessing, the upper layer handles the work that
'start' previously did.  If you need to check if the interface is up
inside your driver, call netif_running(dev).

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
