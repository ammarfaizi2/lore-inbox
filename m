Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272847AbRIRI22>; Tue, 18 Sep 2001 04:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272856AbRIRI2S>; Tue, 18 Sep 2001 04:28:18 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28940 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272847AbRIRI2M>; Tue, 18 Sep 2001 04:28:12 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dieter =?iso-8859-1?q?N=FCtzel=20?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>, Chris Mason <mason@suse.com>
Subject: Re: Feedback on preemptible kernel patch
Date: Tue, 18 Sep 2001 10:35:21 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net> <1000530869.32365.21.camel@phantasy> <20010918040550Z273827-761+10122@vger.kernel.org>
In-Reply-To: <20010918040550Z273827-761+10122@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010918082829Z16130-2757+562@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 18, 2001 06:06 am, Dieter Nützel wrote:
> Am Samstag, 15. September 2001 07:14 schrieb Robert Love:
> > On Sat, 2001-09-15 at 00:25, Dieter Nützel wrote:
> > > It seems to be that kswap put some additional "load" on the disk from
> > > time to time. Or is it the ReiserFS thing, again?
> >
> > I don't think its related to ReiserFS.
> 
> I think you are right.

They were bounce buffers, meaning they can come from any page cache io, and I 
saw at least one report with the same symptoms without the preempt patch.  I 
don't think it's your problem.

--
Daniel
