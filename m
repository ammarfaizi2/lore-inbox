Return-Path: <linux-kernel-owner+w=401wt.eu-S1760831AbWLINRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760831AbWLINRr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760835AbWLINRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:17:47 -0500
Received: from ag-out-0708.google.com ([72.14.246.242]:35704 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760831AbWLINRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:17:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mrUa85KWxOQ/LEHjGJt3PqMhppJ9ec5uKoGmUV1srPImdvR2HCvkbmS2zzTUiclfi85bEbz9U1+ARAiZrpvoJib6pA1FnSNnWbgGQi0iv233gxAV4f+rXJgNNfkeyjccWaxwMVjt9I5OkQCEcNs+7J/p9sxP+CWh8D3p3eG694c=
Message-ID: <2a6e8c0d0612090517j5afe2161p591203c70ddfc890@mail.gmail.com>
Date: Sat, 9 Dec 2006 08:17:46 -0500
From: "Ian E. Morgan" <penguin.wrangler@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Loud POP from sound system during module init w/ 2.6.19
Cc: LKML <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
In-Reply-To: <Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
	 <Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previous kernel was 2.6.18.3, which did not exhibit the problem. I was
aware of udev setting the mixer at module load time, but I disabled
that and the problem still exists.

-- 
Ian E. Morgan
penguin.wrangler@gmail.com

On 09/12/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> On Dec 8 2006 13:53, Ian E. Morgan wrote:
> >Subject: Loud POP from sound system during module init w/ 2.6.19
>
> What kernel did you have before?
>
> What you see is the same I am experiencing on every boot - when the sound
> module is loaded, udev loads the previous volume settings. The volume settings
> are normal for me, but I guess the instant jump from 0-70% (for Master) and
> 0-61% (for PCM) is not taken too heartly by the soundcard.
>
> > Since upgrading to 2.6.19, two of my boxes (one workstation, one
> > notebook) started making a very loud (and scary) POP from the sound
> > system when the alsa modules are loaded. Unloading and reloading the
> > modules will generate another pop.
> >
> > Anybody else seeing this behaviour and know how to stop it?
