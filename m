Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317660AbSGJXBC>; Wed, 10 Jul 2002 19:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317662AbSGJXBB>; Wed, 10 Jul 2002 19:01:01 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:61359 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317660AbSGJXBA> convert rfc822-to-8bit; Wed, 10 Jul 2002 19:01:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Organization: Linux-Systeme GmbH
To: Daniel Phillips <phillips@arcor.de>,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: htree directory indexing 2.4.18-2 BUG with highmem and also high i/o
Date: Thu, 11 Jul 2002 01:03:37 +0200
X-Mailer: KMail [version 1.4]
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
References: <200207092333.01130.mcp@linux-systeme.de> <20020710210153.GA1045@clusterfs.com> <E17SQE4-00029R-00@starship>
In-Reply-To: <E17SQE4-00029R-00@starship>
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207110103.37380.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 00:46, Daniel Phillips wrote:

Hi Daniel, Hi Andreas,

> On Wednesday 10 July 2002 23:01, Andreas Dilger wrote:
> > On Jul 09, 2002  23:33 +0200, Marc-Christian Petersen wrote:
> > > Hi Daniel,
> > >
> > > I've found a bug with htree directory indexing patch and
> > > highmem enabled (64GB). This is with 2.4.18 and htree patch
> > > 2.4.18-2. Oops appears if accessing an ext2 partition with ls
> > > or doing "who/w" in the directory of the ext2 partition.
> >
> > The ext2 htree patch probably needs to add a "kmap()" and "kunmap()"
> > in the function that reads a page and scans the directory for the
> > name it is looking for.  I can't be any more specific than this
> > right now since I only have the ext3 version of this patch, and it
> > does not have page-cache based directories (it is still using the
> > buffer cache).

Say, where can i find those patch for ext3? I've searched a long time and 
never found it?! :|


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.
