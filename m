Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbTCNP3h>; Fri, 14 Mar 2003 10:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263372AbTCNP3h>; Fri, 14 Mar 2003 10:29:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1236
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263370AbTCNP3f>; Fri, 14 Mar 2003 10:29:35 -0500
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Haverkamp <markh@osdl.org>
Cc: Doug Ledford <dledford@redhat.com>, dougg@torque.net,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <1047656071.7556.12.camel@markh1.pdx.osdl.net>
References: <20030228133037.GB7473@jiffies.dk>
	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>
	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>
	 <3E6FC8D6.7090005@torque.net>
	 <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>
	 <1047570132.30105.7.camel@markh1.pdx.osdl.net>
	 <3E711194.9010505@redhat.com>
	 <1047597729.30103.386.camel@markh1.pdx.osdl.net>
	 <3E71134F.5060404@redhat.com>
	 <1047653879.29544.9.camel@irongate.swansea.linux.org.uk>
	 <1047656071.7556.12.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047660502.29544.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 16:48:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 15:34, Mark Haverkamp wrote:
> Is aac_slave_configure only called for disk devices?  If its called for
> all scsi devices, then the queue depth will always be set to something a
> lot less than 512.  I did some searching through the scsi code and I see
> only two places that cmd_per_lun is used. It is used to set the queue
> depth in scsi_track_queue_full and scsi_alloc_sdev. So it seems that, if
> aac_slave_configure gets called for all scsi devices, that setting
> cmd_per_lun in the aacraid scsi host template to 1 would be OK.  Does
> that make sense or did I miss something?

I think you are right

