Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267261AbUBMWnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbUBMWnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:43:18 -0500
Received: from [212.28.208.94] ([212.28.208.94]:35081 "HELO dewire.com")
	by vger.kernel.org with SMTP id S267263AbUBMWj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:39:56 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: root@chaos.analogic.com
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 23:39:53 +0100
User-Agent: KMail/1.6.1
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
References: <1076604650.31270.20.camel@ulysse.olympe.o2t> <20040213181542.GD8858@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.53.0402131325470.1895@chaos>
In-Reply-To: <Pine.LNX.4.53.0402131325470.1895@chaos>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402132339.53924.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 19.31, Richard B. Johnson wrote:
> On Fri, 13 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> > On Fri, Feb 13, 2004 at 07:06:46PM +0100, Nicolas Mailhot wrote:
> > > And as for the filename problems :
> > > - just mangle existing invalid filenames when a default encoding is
> > > agreed upon
> > > - refuse to write new files with invalid filenames just like you would
> > > with the few names forbidden in ascii - apps will learn to cope.
> >
> > What names forbidden in ASCII?
> 
> I think that all ASCII characters below 0x20 are forbidden in
> Unix file-names and others shown in the reference cited and
> "disapproved".
> 
> http://www.med.nyu.edu/rcr/rcr/nyu_vms/unixfileanddirectorynames.htm

That's not really a formal definition of what's allowed. It's a recommendation
for users on how to avoid detecting applications that cannot handle all file names,
i.e. buggy applications. Try 

	touch "$(/bin/ls -1|head)"

and you will find apps that can handle the nice filename and those that cannot. I'm
definitely not endorsing them and it would probably be wise to implement a system policy that
allows administrators to ban such names as they represent security holes and all sorts of
problems.

Some filesystems forbid these names, but unix doesn't.

-- robin
