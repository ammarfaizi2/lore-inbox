Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130345AbRCBHqb>; Fri, 2 Mar 2001 02:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130346AbRCBHqU>; Fri, 2 Mar 2001 02:46:20 -0500
Received: from 4dyn170.com21.casema.net ([212.64.95.170]:44812 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130345AbRCBHqI>;
	Fri, 2 Mar 2001 02:46:08 -0500
Date: Fri, 2 Mar 2001 08:45:45 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: ftruncate not extending files?
Message-ID: <20010302084544.A26070@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103011502050.23650-100000@swamp.bayern.net> <E14YXft-0008GK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <E14YXft-0008GK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 01, 2001 at 06:19:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 06:19:35PM +0000, Alan Cox wrote:
> > In that case, why was it changed for FAT only? Ext2 will still
> > happily enlarge a file by truncating it.
> 
> ftruncate() and truncate() may extend a file but they are not required to
> do so.

Stevens' example code assumes that it does. And given the number of people
that regard his work as Holy, it might not be a bad idea to implement Linux
so that it does what people think it does.

I would've sworn, based on the fact that I saw people do it, that ftruncate
was a legitimate way to extend a file - especially useful in combination
with mmap().

I don't really care where it is done, in glibc or in the kernel - but let's
honor this convention and not needlessly break code.

Regards,

bert hubert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
