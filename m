Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVL2AII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVL2AII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVL2AIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:08:07 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:63754 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932557AbVL2AIG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:08:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JEcrZJiXw6ZSHXQsmgZwDiEJk9LD/EX0q+LlSOU6Ngw0djZbMAKkUTd/OHBoMCx+Gf18K/5HksePO0vP5OFJi718TPab9CEm++qmPMKArUCHAEPgVMmGFir5g+3tZcDlDrKNIE1+Z1mdhuEFYR4MNsXNasxAyBsXIhEgr1aDiVI=
Message-ID: <9611fa230512281608g45aace26hd84d68cf1668a807@mail.gmail.com>
Date: Thu, 29 Dec 2005 00:08:05 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: [BUG]: Hard lockups continue with linux-2.6.15-rc1-rc7
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <9611fa230512281558m339739a6v709b963c9c8933b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230512260357gcb3a163tae35f7e69f1ee7df@mail.gmail.com>
	 <84144f020512260448w119fa376uea3bf985c35a70a6@mail.gmail.com>
	 <9611fa230512281558m339739a6v709b963c9c8933b3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

Thanks for the reply. I will try out that and let know the results.

Regards,


On 12/26/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Hi Tarkan,
>
> On 12/26/05, Tarkan Erimer <tarkane@gmail.com> wrote:
> > I'm having hard lockups with all the RCs of linux-2.6.15. I,
> > previously, mentioned this with the subject "[BUG]: Software compiling
> > occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2" in the
> > list. I investigated a bit at found these interesting things.
> >
> > -- Always reproducable. To reproduce:
> >     - in console 1, issueing "updatedb"
> >     - in console 2, issueing "find / -name "blahblah" -print
> >     - in console 3, issueing "emerge -uDp world" (BTW, I'm using Gentoo.)
> >     - in console 4, X started.
> >     - a few minutes later, system completely freezes. No Alt+SysRq+t
> > works. (Normally, it does)
> >
> > When the system freezes, there is nothing in logs. But hardly, I
> > captured an  Alt+SysRq+t. A few seconds (15-20 seconds) before hang. I
> > attached this  Alt+SysRq+t and lsmod output. Hope this helps to solve
> > this.
>
> You can use git bisect to narrow down the changeset that introduced
> the bug. Please refer to the following URL for details:
> http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt
>
>                         Pekka
>
