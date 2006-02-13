Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWBMOHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWBMOHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWBMOHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:07:33 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:11137 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751770AbWBMOHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:07:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HYpfQB9oCoXqfCLC1rALb1ooYz30cXCXnLwEiyF2lZA4peCah8WmtSxbbaMpuJtZ+j28IwZbwekb3L3hl0kZQXhG6uVmCTFp6OPM2iqZ1TOvmwgFF8t8TfTk1t332KtmdxGYvAKTiuS/Yg/NuFuk9ZVMiWabGapM4ZvZRjhWLLM=
Message-ID: <5a2cf1f60602130607v5954d1a6qc738dd608aaf9b96@mail.gmail.com>
Date: Mon, 13 Feb 2006 15:07:29 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: davidsen@tmr.com, chris@gnome-de.org, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <43F088AB.nailKUSB18RM0@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	 <20060125144543.GY4212@suse.de>
	 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	 <20060125153057.GG4212@suse.de> <43ED005F.5060804@tmr.com>
	 <1139615496.10395.36.camel@localhost.localdomain>
	 <43F088AB.nailKUSB18RM0@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
[...]
> > > Since -scanbus tells you a
> > > device is a CDrecorder, or something else, *any user* is likely to be
> > > able to tell it from DCD, CD-ROM, etc. Nice like of text for most devices...
> >
> > Well, "any user" just opens his Windows Explorer and takes a look at the
> > icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
> > interesting to see professional programmers often argue that a
>
> This is not true: a drive letter mapping does not need to exist on MS-WIN
> in order to be able to access it via ASPI or SPTI.

But from a user perspective, how one is supposed to identify between 2
identical burners named D: and E: on their system if cdrecord only
provides b,t,l naming and "b,t,l to cd burner name" mapping?

The "OS specific to b,t,l" mapping is clearly lacking although
cdrecord knows it there as well. Cf. scsi-wnt.c:

#ifdef _DEBUG_SCSIPT
        js_fprintf(scgp_errfile,  "SPTI: Adding drive %c: (%d:%d:%d)\n", 'A'+i,
                                        pDrive->ha, pDrive->tgt, pDrive->lun);
#endif

Jerome
