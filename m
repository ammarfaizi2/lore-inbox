Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWBJNCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWBJNCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWBJNCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:02:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17312 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751254AbWBJNCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:02:36 -0500
Date: Fri, 10 Feb 2006 13:02:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: mrmacman_g4@mac.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210130228.GA30256@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"D. Hazelton" <dhazelton@enter.net>, mrmacman_g4@mac.com,
	peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com> <43EC83EC.nailISD91HRFF@burner> <200602090737.47747.dhazelton@enter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602090737.47747.dhazelton@enter.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 07:37:46AM -0500, D. Hazelton wrote:
> read relevant sections of the POSIX and SuS when looking at problems and know 
> that the _proper_, _portable_ and _UNIX_ way of accessing devices is via the 
> block device special file. For SCSI cd burners the only way (I know of) to 
> access them for writing (as /dev/sr0 cannot be opened for "write")

You can access SCSI CDs using /dev/sr* for burning CDs.  It's backed by the
same highlevel code as SG_IO on /dev/hd* while the lowerlevel handling is
done transparently by the scsi midlayer, the same code used by /dev/sg* for
the below-blocklayer handling.

