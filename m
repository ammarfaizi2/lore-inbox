Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbTCNNjP>; Fri, 14 Mar 2003 08:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263355AbTCNNjP>; Fri, 14 Mar 2003 08:39:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28370
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263354AbTCNNjN>; Fri, 14 Mar 2003 08:39:13 -0500
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug Ledford <dledford@redhat.com>
Cc: Mark Haverkamp <markh@osdl.org>, dougg@torque.net,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <3E71134F.5060404@redhat.com>
References: <20030228133037.GB7473@jiffies.dk>
	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>
	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>
	 <3E6FC8D6.7090005@torque.net>
	 <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>
	 <1047570132.30105.7.camel@markh1.pdx.osdl.net>
	 <3E711194.9010505@redhat.com>
	 <1047597729.30103.386.camel@markh1.pdx.osdl.net>
	 <3E71134F.5060404@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047653879.29544.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 14:57:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 23:25, Doug Ledford wrote:
> Mark Haverkamp wrote:
> > Then it sounds like the aacraid driver could set cmd_per_lun to a small
> > number like one since the real queue depth will be set later in
> > aac_slave_configure.
> 
> Yes.  And since the driver doesn't support anything other than drives to 
> my knowledge, 1 would be appropriate.

It supports both disks and non disk devices. Disks are mapped onto bus 0
and are driven via firmware smarts as logical devices, non disks are bus 1
and there it behaves mostly like a scsi controller

