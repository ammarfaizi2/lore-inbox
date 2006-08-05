Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWHERN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWHERN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 13:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWHERN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 13:13:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:11530 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030251AbWHERN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 13:13:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FUHvipnBmy1qs9XOBDVHMnlo9VZVGm2nLiCVCq2mv4Ylazfdh9yP2MP5POQOn9KqCLKibcoRQnkbEhrECmdej8ecoTBM5PHj603ExHZViakER/l/MjmVeYHI9wh7hgWyyUO/LMKlg2WSF5zdSdfl3CGKfZVph47Ty2KEtmfNPXg=
Message-ID: <abcd72470608051013s42ba14e1g8c3289a3e551c7ca@mail.gmail.com>
Date: Sat, 5 Aug 2006 10:13:26 -0700
From: "Avinash Ramanath" <avinashr@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Zeroing data blocks
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <1154790620.3054.69.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <abcd72470607081856i47f15dedre9be9278ffa9bab4@mail.gmail.com>
	 <1152435182.3255.39.camel@laptopd505.fenrus.org>
	 <abcd72470608050055w51f2bfbcrbd26b59fc32dc494@mail.gmail.com>
	 <1154790620.3054.69.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to do this at the filesystem-level not in user-space.
I have a stackable-filesystem that runs as a layer on top of the
existing filesystem (with all the function pointers mapped to the
corresponding base filesystem function pointers, and other suitable
adjustments).
So yes I have access to the filesystem.
But the question is how can I access those particular data-blocks?

On 8/5/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-08-05 at 00:55 -0700, Avinash Ramanath wrote:
> > Hi,
> >
> > As per your suggestion, if I write a file with zero bits, it would
> > remap to other pages, and I might not zero the real pages. So is there
> > any other way that I can access the pages that a file is using?
>
> there is an ioctl to find the blocks the file is in.. but still that's
> only a snapshot, not a guarantee. What you really need/want is to do
> this at the filesystem level, you can't reliably do it above that level.
>
> --
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com
>
>
>
