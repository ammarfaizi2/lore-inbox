Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129151AbQJ0JcU>; Fri, 27 Oct 2000 05:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129264AbQJ0JcK>; Fri, 27 Oct 2000 05:32:10 -0400
Received: from hermes.mixx.net ([212.84.196.2]:2323 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129151AbQJ0JcB>;
	Fri, 27 Oct 2000 05:32:01 -0400
Message-ID: <39F94B8F.C2293ADD@innominate.de>
Date: Fri, 27 Oct 2000 11:31:59 +0200
From: Juri Haberland <juri.haberland@innominate.de>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-NFS-RAID i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quota fixes and a few questions
In-Reply-To: <20000927145620.B8484@atrey.karlin.mff.cuni.cz> <20001007003134.B4732@redhat.com> <news2mail-39EAE3A3.7D08CD8B@innominate.de> <news2mail-39EF0906.E7281F12@innominate.de> <20001019190354.A15755@atrey.karlin.mff.cuni.cz> <20001020154204.A1863@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Thu, Oct 19, 2000 at 07:03:54PM +0200, Jan Kara wrote:
> >
> > > I stumbled into another problem:
> > > When using ext3 with quotas the kjournald process stops responding and
> > > stays in DW state when the filesystem gets under heavy load. It is easy
> > > to reproduce:
> > > Just extract two or three larger tar.gz files at the same time to a ext3
> > > filesystem with activated quotas...
> 
> Which ext3 version, exactly?  0.0.2f had quota problems because ext3
> wasn't doing quota writethrough, so that inode cleaning could force
> out random dirty quotas at any point.  0.0.3b should fix that.  If it
> doesn't, I'll try to reproduce it here.

Hi Stephen,

unfortunately 0.0.3b has the same problem. I tried it with a stock
2.2.17 kernel + NFS patches + ext3-0.0.3b and the quota rpm you
included. Extracting two larger tar.gz files hits the deadlock reliably.

Juri

-- 
juri.haberland@innominate.de
system engineer                                         innominate AG
clustering & security                               networking people
phone: +49-30-308806-45  fax: -77                http://innominate.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
