Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbUDNLkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 07:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264055AbUDNLkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 07:40:01 -0400
Received: from village.ehouse.ru ([193.111.92.18]:47120 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264052AbUDNLjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 07:39:55 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: admin@list.net.ru
Subject: Re: 2.6.5-aa3: kernel BUG at mm/objrmap.c:137!
Date: Wed, 14 Apr 2004 15:39:49 +0400
User-Agent: KMail/1.6.1
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <200404141257.16731.gluk@php4.ru> <20040414095435.GH2150@dualathlon.random>
In-Reply-To: <20040414095435.GH2150@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141539.49757.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 13:54, Andrea Arcangeli wrote:
> On Wed, Apr 14, 2004 at 12:57:16PM +0400, Alexander Y. Fomichev wrote:
> > G'Day,
> >
> > I've got a bug on 2.6.5-aa3 today
> >
> > System: Dual P4 Xeon 2.4GHz, 4G ECC RAM - (production web-server) pretty   
    btw, i was wrong, this box has only 2G ECC RAM not 4. 
> > 	heavy loaded at most time, but i've got it approximately
> > 	at 02:00 (MSD) when no serious load should be.
> > 	System remained accessible all the time but operations
> > 	with proclist from userspace (i.e. ps, w) appears to be locked.
>
> I don't think apache2 uses nonlinear. there was an smp race fix in
> 2.6.5-aa4, so you may want to try again with 2.6.5-aa5 (latest) just in
> case this was mm corruption triggered by the race.
tnx, i'll try it.
btw, system running on 2.6.5-aa3 almost for a month (at 2004/04/18) and
this is first time i catch this, so 2.6.5-aa3 pretty stable for me. (except 
for trouble mentioned by Sergey Kostyliov as "2.6.X kernel memory 
leak?"/"2.6.1 IO lockup on SMP systems")

> Are you using threading with apache2? Such a race could trigger only
> with threads.

exactly right, apache2 compiled --with-mpm=worker.

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
