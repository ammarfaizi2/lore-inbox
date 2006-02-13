Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWBMRMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWBMRMV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWBMRMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:12:20 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:48007 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932247AbWBMRMT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:12:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uEoJouIb6/iLTF104kVifYGmDqiGYubpwnhbGTMfdblMY/1yJHuaeTtcdjM1D+D4qhkELWTpbIhnEqL8c+DUExO71Vi9kqB7LKd/jwopkqmBhCp2G3HU3rkLLM9DqDLKG++tQCFpfWiRgs6ykzr1wSVCjlV2faM24UIYau/CFwA=
Message-ID: <5a2cf1f60602130912u7e8d28c4w4ef1749ff6c73142@mail.gmail.com>
Date: Mon, 13 Feb 2006 18:12:17 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
In-Reply-To: <43F0B2BA.nailKUS1DNTEHA@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo> <43EC8F22.nailISDL17DJF@burner>
	 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
	 <43F06220.nailKUS5D8SL2@burner>
	 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
	 <43F0A010.nailKUSR1CGG5@burner>
	 <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
	 <43F0AA83.nailKUS171HI4B@burner>
	 <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
	 <43F0B2BA.nailKUS1DNTEHA@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> > The mapping I am talking about is currently done inside libscg (inside
> > the scsi-*.c files). Hence libscg is the one capable of exposing this
> > information to higher levels.
> >
> > > and how would you like to implement it OS independent?
> >
> > The information printed will be printed in a format such as:
> >
> > b,t,l <= os_specific_name
>
> Why do you believe that this kind of mapping is needed?

To make it so that:

- cdrecord keeps its dev=b,t,l command line interface

- a cdrecord wrapper program lets a user specify the os specific name
to access the drive. The wrapper program would identify the b,t,l name
and feed it correctly to cdrecord. This can also be used to correctly
identify 2 identical drives using their OS specific names.

-scanbus displays:
1,0,0: DRIVE MODEL XYZ
2,0,0: DRIVE MODEL XYZ

but thank to that proposal, one would also have:

1,0,0 <= /dev/hdc
2,0,0 <= /dev/hdd

I think it's a good compromise between what the users want and what you want.

So, WDYT?

Jerome
