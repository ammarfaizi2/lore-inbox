Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVCNMkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVCNMkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 07:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVCNMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 07:40:20 -0500
Received: from dialpool1-79.dial.tijd.com ([62.112.10.79]:32431 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261468AbVCNMkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 07:40:13 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Subject: Re: cpufreq on-demand governor up_treshold?
Date: Mon, 14 Mar 2005 13:40:58 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, cpufreq@zenii.linux.org.uk, davej@redhat.com,
       linux@dominikbrodowski.net
References: <200503140829.04750.lkml@kcore.org> <42354400.7070500@tremplin-utc.net>
In-Reply-To: <42354400.7070500@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503141340.59714.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 March 2005 08:57, Eric Piel wrote:
> Jan De Luyck a écrit :
> > Hello lists,
> >
> > (please cc me from cpufreq list)
> >
> > I've since yesterday started using the ondemand governor. Seems to work
> > fine, tho I can't seem to find a reason why it keeps scaling my processor
> > speed upwards tho the processor use never exceeds 30% (been watching top
> > -d 1).
> >
> >
> > Any hints?
>
> You can try the three attached patches in the order :
> ondemand-cleanup-factorise-idle-measurement-2.6.11.patch
> ondemand-save-idle-up-for-all-cpu-2.6.11.patch
> ondemand-automatic-downscaling-2.6.11-accepted.patch
>
> They are available on the cpufreq list but as it's difficult to access
> it I'm sending them again, all together. These are the last things that
> Venki and I have been working on. It should solve your problem
> (actually, only the last patch, but it depends on the two previous
> patches). Please, let me know if it works.

Okay, now the behaviour of the ondemand governor looks more 'sane'. Thanks, it 
looks like a huge improvement :)

Jan

-- 
Snow and adolescence are the only problems that disappear if you ignore
them long enough.
