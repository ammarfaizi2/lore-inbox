Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289581AbSBSUCs>; Tue, 19 Feb 2002 15:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSBSUCi>; Tue, 19 Feb 2002 15:02:38 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:42739 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289697AbSBSUCZ>;
	Tue, 19 Feb 2002 15:02:25 -0500
Date: Tue, 19 Feb 2002 13:01:27 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Jens Schmidt <j.schmidt@paradise.net.nz>, linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
Message-ID: <20020219130127.C25713@lynx.adilger.int>
Mail-Followup-To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Jens Schmidt <j.schmidt@paradise.net.nz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <31030000.1014141568@flay> <200202191848.TAA08419@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202191848.TAA08419@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Tue, Feb 19, 2002 at 07:48:58PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 19, 2002  19:48 +0100, Rogier Wolff wrote:
> Maybe the difference is in "what's the goal". For datarecovery we
> don't really care about just a couple of bits here and there: We want
> to piece together the whole thing. 
> 
> If you don't want a piece of your data getting into wrong hands
> however, you'd better be safe than sorry.
> 
> So I (and the Ibas guy) are talking about practical recovery of a
> useful amount of data, while even a couple of bits is in theory
> dangerous if you really want it "gone".

So, as others have said, if your data is so important that you are
worried about people taking the platter and putting it under a
scanning-tunneling microscope (or whatever is in vogue) to recover
deleted data, then you should be one million times as worried about
undeleted data on the same disk (i.e. what happens if they steal or
copy the disk _before_ you delete this precious data).

The net result is that this data should never hit the disk unencrypted
in the first place, at which point you don't need to worry about the
deletion step.  You have encrypted swap and encrypted loopback filesystems,
and you have proper procedure to ensure the keys are safe, and all is well.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

