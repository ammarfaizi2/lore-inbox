Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVG1KhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVG1KhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVG1KhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:37:11 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:64871 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261402AbVG1KhD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:37:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BE/NX26nEEIV2hJYmnDEEWck26qQuywZvP5MhQspZRhJh/qPC7lClmiNwhv9Ed+8M3Ilsp71LA9FQWyn9zg1h9HUgUl/LIB7jllLQdGQYsHXdI5v2OWI14eW7xjdv4x9zWhVuzAO5uDDVrQK658h6f61bpmn5OElxcdh3Pp+N6Q=
Message-ID: <b115cb5f050728033662fb288a@mail.gmail.com>
Date: Thu, 28 Jul 2005 19:36:15 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: Incorrect driver getting loaded for Qlogic FC-HBA
Cc: Greg KH <greg@kroah.com>, kernelnewbies@nl.linux.org,
       linux-scsi@vger.kernel.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050727181135.GI7114@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b115cb5f0507241902653b6f72@mail.gmail.com>
	 <20050726000600.GB23858@kroah.com>
	 <b115cb5f050725211615cfab78@mail.gmail.com>
	 <20050726155253.GB8462@plap.qlogic.org>
	 <b115cb5f05072623016a713629@mail.gmail.com>
	 <20050727181135.GI7114@plap.qlogic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > A similar problem was noted with RHEL4, it seems the modules.pcimap
> > > and pci.ids file were correct, but the pcitable file contained entries
> > > for all ql[ae]23xx based HBAs to load qla2300.ko.
> > >
> > > It's my understanding that this was fixed for RHEL4 U1.  Which distro
> > > are you using?  If you are using RHEL, and are still having problems,
> > > I'd suggest you file a report with Redhat.
> > >
> > > Regards,
> > > Andrew Vasquez
> > >
> >
> > BINGO! I AM using RHEL 4. So does that mean I can rectify the problem
> > by making appropriate changes to "pcitable" file?
> 
> I'm trying to get a firm answer from the folks who originally
> discvoered the problem some time back, it seems you have two options:

Hey Thanks. I would really appreciate if you could update list/me on
it IF you get any updates (I know its too much pain).


>  - (post installation) modify the /etc/modprobe.conf to and rename the
>   qla2300 entry to qla2322 (i.e.):
> 
>        alias scsi_hostadapter1 qla2322
> 
>   modify the modules.pcimap table to load qla2322 for the 2322
>   device-id:
> 
>        qla2300         0x00001077      0x00002322      ...
> 
>   to:
> 
>        qla2322         0x00001077      0x00002322      ...
> 
> 
> Beyond that, I'd suggest you log a report with Redhat, as that's the
> extent of the workaround knowledge without going to RHEL4U1.
> 
> Hope this helps,
> Andrew Vasquez
> 

THANKS. It worked for me, for time being. 
In the mean time, I plan to file  report with RedHat and will update
list as and when I get any response.

regards,

Rajat
