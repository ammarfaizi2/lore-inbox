Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWBEQPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWBEQPn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 11:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWBEQPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 11:15:43 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:55766 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750822AbWBEQPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 11:15:42 -0500
Message-ID: <43E62492.6080506@cfl.rr.com>
Date: Sun, 05 Feb 2006 11:15:14 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602 <Pine.LNX.4.61.0602050838110.6749@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602050838110.6749@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> I would say we all forgot to RTFM. Because O_EXCL does nothing *unless* 
> O_CREAT is specified, which probably *is not* specified in cdrecord or 
> hal. There is no reason to have hal or cdrecord create a device node - 
> which you can't do with open() anyway.
> 

I think you are misinterpreting the man page, because it isn't worded 
very clearly.  It should not even mention O_CREAT because it has nothing 
to do with O_EXCL; it is just repeating the semantics of O_CREAT ( if 
the file already exists, the call fails ) which would of course, apply 
if you do use O_CREAT in conjunction with any other flag including 
O_EXCL.  It does not say that you must use O_EXCL with O_CREAT.  The 
rest of the description talks about using lockfiles as an alternative to 
ensure exclusive access to the file on NFS where O_EXCL is broken.  The 
intent of O_EXCL is clearly to provide the caller with exclusive access 
to the file.



