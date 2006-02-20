Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWBTQaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWBTQaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWBTQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:30:15 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:28029 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161008AbWBTQaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:30:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KtGUHqMRhFipm+ZO5s/Evwe60fnScAIm0ZDiPQFjDEXy8/oImo1QdCAElZzCyyIM68sDTErBbTxRBdRo+4RpOIgY9oxOzyJnDJANk5sbksmsN1jvbl+uwTZQIscTsbTxch7zbDwtfna+B0eO2NbYySzPwqrsJsyS/MYFgmRiGWI=
Message-ID: <d120d5000602200830m190874f5jf253b106b6821049@mail.gmail.com>
Date: Mon, 20 Feb 2006 11:30:12 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Cc: "Pavel Machek" <pavel@ucw.cz>, "Mark Lord" <lkml@rtr.ca>,
       "Nigel Cunningham" <nigel@suspend2.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200602201722.09442.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
	 <d120d5000602200708n2984fda9j62c3d7ba21b3e8ae@mail.gmail.com>
	 <200602201722.09442.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 20 February 2006 16:08, Dmitry Torokhov wrote:
> > On 2/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> > > >
> > > > I know I am bad for not reporting that earlier but swsusp was working
> > > > OK for me till about 3 month ago when I started getting "soft lockup
> > > > detected on CPU0" with no useable backtrace 3 times out of 4. I
> > > > somehow suspect that having automounted nfs helps it to fail
> > > > somehow...
> > >
> > > Disable soft lockup watchdog :-).
> >
> > Ok, I will try, but is this the permanent solution you are proposing?
>
> Certainly not.
>
> The problem is the soft lockup watchdog tends to produce false-positives
> related to the clock resume vs timer interrupt dependencies that are
> hard to trace.
>
> I used to get those on a regular basis until the timer resume on x86-64
> got fixed a month ago or so.
>
> Please try the latest -mm and see if it's not fixed there.  If not, please
> file a bug report with bugzilla (with Cc to me).
>

Latest -mm is way too big a target. Do you have a specific patches in
mind? Again my working kernel is based off tip of Linus's tree plus my
patches, not -mm.

--
Dmitry
