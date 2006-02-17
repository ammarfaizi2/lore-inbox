Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWBQVBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWBQVBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWBQVBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:01:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23723 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751688AbWBQVBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:01:17 -0500
Date: Fri, 17 Feb 2006 21:01:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Christoph Hellwig <hch@infradead.org>, "D. Hazelton" <dhazelton@enter.net>,
       mrmacman_g4@mac.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060217210107.GA20411@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bill Davidsen <davidsen@tmr.com>,
	"D. Hazelton" <dhazelton@enter.net>, mrmacman_g4@mac.com,
	peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com> <43EC83EC.nailISD91HRFF@burner> <200602090737.47747.dhazelton@enter.net> <20060210130228.GA30256@infradead.org> <43F63846.80109@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F63846.80109@tmr.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 03:55:34PM -0500, Bill Davidsen wrote:
> Christoph Hellwig wrote:
> 
> >You can access SCSI CDs using /dev/sr* for burning CDs.  It's backed by 
> >the
> >same highlevel code as SG_IO on /dev/hd* while the lowerlevel handling is
> >done transparently by the scsi midlayer, the same code used by /dev/sg* 
> >for
> >the below-blocklayer handling.
> >
> This may be true if you create your own /dev entries, or are a udev guru 
> and can get it to generate the right entries. And if you use ATAPI 
> devices it works fine... But with Fedora and SuSE it appears that USB 
> devices which appear as SCSI aren't functional. I tested the Fedora 
> myself, and after killing udevd and making some entries by hand it 
> worked once.
> 
> Now if you can access SCSI burners more power to you, with FC4 up to 
> recent updates, my one convenient real SCSI device most definitely 
> doesn't work, and I havd to fall the system back to Slackware and 2.4 
> which was on it before.
> 
> Because you know how to get around the problems doesn't really suggest 
> that there aren't any.

How are the dev entires related to CD burning?  If the device entries
don't appear for you that's a problem, but you deserve what you get
for using a POS like udev.  If you have a sd or sr node you can use
SG_IO on it, period.  Whether you can actually burn a CD of course
depends on the capability of the device.  I don't have a CD burner
connected through usb, but I couldn't think of a reason the usb <-> atapi
bridge would make problems with the scsi commands used to burn a CD.
