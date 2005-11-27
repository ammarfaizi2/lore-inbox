Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVK0BiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVK0BiS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVK0BiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:38:18 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:48086 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750806AbVK0BiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:38:17 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: David Brown <dmlb2000@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Date: Sun, 27 Nov 2005 01:38:25 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <200511262346.27907.s0348365@sms.ed.ac.uk> <9c21eeae0511261713vacf13f5u5fdf19711635a381@mail.gmail.com>
In-Reply-To: <9c21eeae0511261713vacf13f5u5fdf19711635a381@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511270138.25769.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 November 2005 01:13, David Brown wrote:
> > David, it'd probably help if you listed all of the affected files, then
> > people can explain themselves and/or correct the permissions.
> >
> > I personally think that your point is valid and security should be
> > considered when packing the kernel sources. It might even be possible for
> > Linus's tarball script to remove global write permissions.
>
> Okay but it's kinda big here's how I did it.
>
> # for file in `find *` ; do if ls -l $file | grep -q '^.....w..w.' ;
> then ls -d $file ; fi ; done | wc -l
> 19552
> # find * | wc -l
> 19552
>
> seems to be all of them :\
>
> I'll attach the file list

Sure enough, I can confirm this.

I don't seem to have to provide --no-same-permissions to tar to get umask to 
affect the permissions of extracted files, so my files are fine on-disc.

What disturbs me more is the number of people using insecure umasks before 
checking files in! When does a text file really want to be a+w?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
