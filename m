Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136264AbRECI6W>; Thu, 3 May 2001 04:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136267AbRECI6M>; Thu, 3 May 2001 04:58:12 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:26896 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S136264AbRECI56>; Thu, 3 May 2001 04:57:58 -0400
Date: Thu, 3 May 2001 20:57:54 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org,
        cw@f00f.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Message-ID: <20010503205754.A26313@metastasis.f00f.org>
In-Reply-To: <200105011653.f41Grwm12595@vindaloo.ras.ucalgary.ca> <E14ugpA-0002J3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14ugpA-0002J3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 01, 2001 at 09:32:41PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 09:32:41PM +0100, Alan Cox wrote:

    Having thought over the issues I plan to maintain a 32bit dev_t kernel with
    conventional mknod behaviour, even if Linus won't. One very interesting item
    that Peter Anvin noted is that its not clear in POSIX that
    
    	mknod /dev/ttyF00 c 100 100
    
    	open("/dev/ttyF00/speed=9600,clocal");
    
    is illegal. That may be a nice way to get much of the desired behaviour without
    totally breaking compatibility

Linus has suggested we do something similar in 2.5.x for multiple
data streams (or forks) in certain filesystems sugh as HFS and
NTFS... you might want to check the two very similar ideas don't
collide.


  --cw
