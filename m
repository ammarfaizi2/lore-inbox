Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292652AbSBZSXw>; Tue, 26 Feb 2002 13:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292420AbSBZSXg>; Tue, 26 Feb 2002 13:23:36 -0500
Received: from unthought.net ([212.97.129.24]:20935 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S292652AbSBZSXC>;
	Tue, 26 Feb 2002 13:23:02 -0500
Date: Tue, 26 Feb 2002 19:23:00 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "H. Peter Anvin" <hpa@zytor.com>, "Rose, Billy" <wrose@loislaw.com>,
        "'Martin Dalecki'" <dalecki@evision-ventures.com>,
        Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226192300.Q28035@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"H. Peter Anvin" <hpa@zytor.com>, "Rose, Billy" <wrose@loislaw.com>,
	'Martin Dalecki' <dalecki@evision-ventures.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com> <3C7BCD4A.9020400@zytor.com> <20020226111509.J12832@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20020226111509.J12832@lynx.adilger.int>; from adilger@turbolabs.com on Tue, Feb 26, 2002 at 11:15:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 11:15:09AM -0700, Andreas Dilger wrote:
> On Feb 26, 2002  10:00 -0800, H. Peter Anvin wrote:
> > Rose, Billy wrote:
> > > My company can tolerate 0% loss of data (which is why I raised this issue).
> > 
> > There is no such thing as 0% loss of data.  You can get some amount of 
> > security with backups, snapshots (really useful!) or undelete, but you 
> > can *NEVER* guarantee 0% loss of data... consider the case when a 
> > (l)user overwrites (not just deletes) a newly created file.
> 
> Snapshots at the filesystem level could handle the overwrite case.
> 
> However, even then it cannot be 0% loss of data, unless you have snapshots
> for _every_ write of the file, which would quickly become prohibitive in
> space usage (think autobackup from an editor on a large file).  Sometimes
> people just have to learn from their mistakes...

That's a logging filesystem.  One that stores the "diff" whenever someone
writes, rm's, truncates, etc. etc.

AFAIK they exist, so it can be done.  Don't know much else about them though.
It does seem like the "elegant" solution to the problem though, if it's ~0%
data loss that's the objective.  Having undelete is far from a full solution
to that problem.

Anyone knows about those devils ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
