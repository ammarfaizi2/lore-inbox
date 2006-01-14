Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWANOt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWANOt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWANOt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:49:57 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:35979 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751739AbWANOt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:49:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F0UlJYJ8EnBg1twqSnzcM70xtX1qsZ1d6UtFy3ua/EPsAyv9XuWj7eZbYhQlMyjY3PmkqLbV/aBJv39baN8Rla828q1prpCRfi0Ojyu8eLZLAxr4sHjjKzP1FeOM8oqa0G/xu/9ACYznQv9VRcbEWfCTSX0b5hbYZEv9P+5wXUw=
Message-ID: <5a4c581d0601140649s1500040fke19de7850c10fa01@mail.gmail.com>
Date: Sat, 14 Jan 2006 15:49:50 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: Re: 2.6.15-git breaks Xorg on em64t
In-Reply-To: <20060114065235.GA4539@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060114065235.GA4539@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, Dave Jones <davej@redhat.com> wrote:
> Andi,
>  Sometime in the last week something was introduced to Linus'
> tree which makes my dual EM64T go nuts when X tries to start.
> By "go nuts", I mean it does various random things, seen so
> far..
> - Machine check. (I'm convinced this isn't a hardware problem
>   despite the new addition telling me otherwise :)
> - Reboot
> - Total lockup
> - NMI watchdog firing, and then lockup
>
> I've tried backing out a handful of the x86-64 patches, and
> didn't get too far, as some of them are dependant on others,
> it quickly became a real mess to try to bisect where exactly it broke.
>
> Any ideas for potential candidates to try & back out ?

Did you perhaps take a look at my report ? -git{6,7} were
 bad for me, and the netconsole stack was, uhm, interesting.

http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/2130.html

-git8 made the problem disappear. Haven't tested more recent
 snapshots.

Ciao,

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
